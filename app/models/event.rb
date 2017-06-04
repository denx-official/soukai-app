class Event < ActiveRecord::Base
  require 'net/http'
  require 'uri'
  require 'json'
  
  EVENT_API_URL = "http://denxcal.aokibazooka.net/events"
  
  def self.check_events
    json = Event.get_events_json().symbolize_keys
    if json[:success]
      events = json[:items].map(&:symbolize_keys)
      category_names = events.map {|event| event[:calendar] }.uniq
      category_ids = Event::Category.all.select {|c| category_names.include?(c.name) }.map(&:id)
      remind_event_categories = User::RemindEventCategory.where(event_category_id: category_ids, is_remind: true).to_a
      users = User.where(id: remind_event_categories.map(&:user_id).uniq).to_a

      events.each do |event|
        event_name = event[:summary]
        category = Event::Category.find(event[:calendar])
        start_time = event[:starttime].to_time
        reminds = remind_event_categories.select {|r| r.event_category_id == category.id}
        
        reminds.each do |remind|
          if start_time - Time.current <= remind.remind_before_day.days
            user = users.find {|u| u.id == remind.user_id }
            NoticeMailer.event_notice(user, event_name, start_time).deliver_now if user.id == 1
          end
        end
        
      end
    else
      admin_users_email = users.select {|u| u.admin? }.map(&:email)
      NoticeMailer.send_notice(admin_users_email, "DENX APPに異常発生", "#{EVENT_API_URL}からくるjsonに異常あり")
    end
    nil
  end
  
  private
  
    def self.get_events_json(location = EVENT_API_URL, limit = 10)
      raise ArgumentError, 'too many HTTP redirects' if limit == 0
      uri = URI.parse(location)
    
      begin
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.open_timeout = 5
          http.read_timeout = 10
          http.get(uri.request_uri)
        end
    
        case response
        when Net::HTTPSuccess
          json = response.body
          JSON.parse(json)
        when Net::HTTPRedirection
          location = response['location']
          warn "redirected to #{location}"
          get_json(location, limit - 1)
        else
          puts [uri.to_s, response.value].join(" : ")
          nil
        end
      rescue => e
        puts [uri.to_s, e.class, e].join(" : ")
        nil
      end
    end
    
end

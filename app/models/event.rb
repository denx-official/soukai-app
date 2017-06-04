class Event < ActiveRecord::Base
  require 'net/http'
  require 'uri'
  require 'json'
  
  EVENT_API_URL = "http://denxcal.aokibazooka.net/events"
  
  def self.check_events
    json = Event.get_json().symbolize_keys
    if json[:success]
      events = json[:items].map(&:symbolize_keys)
      
      category_names = events.map {|event| event[:calendar] }.uniq
      category_ids = Event::Category.all.select {|c| category_names.include?(c.name) }.map(&:id)

      user_remind_event_categories = User::RemindEventCategory.where(event_category_id: category_ids, is_remind: true).to_a
      users = User.where(id: user_remind_event_categories.map(&:user_id)).to_a
      
      events.each do |event|
        category = Event::Category.find(event[:calendar])
        remind_user_ids = user_remind_event_categories.select {|user_remind_event_category| user_remind_event_category.event_category_id == category.id }.map(&:user_id)
        remind_users = users.select {|user| remind_user_ids.include?(user.id) }
        # NoticeMailer.send_notice(users, params[:subject], params[:body]).deliver_now
        p remind_users.map(&:id)
      end
    end
  end
  
  private
  
    def self.get_json(location = EVENT_API_URL, limit = 10)
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

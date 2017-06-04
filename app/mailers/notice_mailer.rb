class NoticeMailer < ApplicationMailer
  
  def send_notice(user_mails, subject, body)
    @body = body
    mail bcc: user_mails, subject: subject
  end
  
  def event_notice(user, event_name, start_time)
    @user = user
    @event_name = event_name
    @start_time = start_time
    
    mail to: user.email, subject: "[DENX APP] #{event_name}のお知らせ"
  end
  
end

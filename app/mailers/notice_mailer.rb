class NoticeMailer < ApplicationMailer
  
  def send_notice(users, subject, body)
    @body = body
    users.each do |user|
      mail to: user.email, subject: subject
    end
  end
  
end
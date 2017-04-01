class NoticeMailer < ApplicationMailer
  def send_notice(users, subject, body)
    @body = body
    mail bcc: users.map(&:email), subject: subject
  end
end

module Common
  extend ActiveSupport::Concern
  
  def attend?(user, soukai)
    Attendance.where(user_id: user, soukai_id: soukai).present?
  end
  
  def select_layout
    "application_mobile" if request.from_smartphone?
  end

end
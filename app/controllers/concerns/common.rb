module Common
  extend ActiveSupport::Concern
  
  def return_attend(user, month)
    Attendance.where(user_id: user, soukai_id: narrow_soukai_and_return_month(month)).present?
  end
  
  def narrow_soukai_and_return_month(month)
    Soukai.narrow_month(month).first.date.month
  end
  
  def select_layout
    "application_mobile" if request.from_smartphone?
  end

end
module Common
  extend ActiveSupport::Concern
  
  def return_attend(user, month, year)
    Attendance.where(user_id: user, soukai_id: narrow_soukai(month, year)).present?
  end
  
  def narrow_soukai(month, year)
      Soukai.narrow_year(year).narrow_month(month).first.date.month
  end
  
  def select_layout
    "application_mobile" if request.from_smartphone?
  end

end
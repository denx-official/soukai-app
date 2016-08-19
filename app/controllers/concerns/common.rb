module Common
  extend ActiveSupport::Concern
  
  def set_atttend_month_as_hash(user, year)
    {
    ' 4月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(4, year)).present?,
    ' 5月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(5, year)).present?,
    ' 6月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(6, year)).present?,
    ' 7月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(7, year)).present?,
    ' 8月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(8, year)).present?,
    ' 9月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(9, year)).present?,
    '10月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(10, year)).present?,
    '11月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(11, year)).present?,
    '12月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(12, year)).present?,
    ' 1月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(1, year)).present?,
    ' 2月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(2, year)).present?,
    ' 3月' => Attendance.where(user_id: user, soukai_id: soukai_narrow_month(3, year)).present?
    }
  end
  
  def soukai_narrow_month(month, year)
    if Rails.env.development?
      Soukai.where("cast(strftime('%Y', date) as int) = ?", year)
           .where("cast(strftime('%m', date) as int) = ?", month)
           .first.date.month
    else
      Soukai.where("extract(year  from date) = ?", year)
            .where("extract(month from date) = ?", month)
            .first.date.month
    end
  end
  
end
module Common
  extend ActiveSupport::Concern
  
  def set_month(user)
    @jan = Attendance.where(user_id: user, soukai_id: 1).present?
    @feb = Attendance.where(user_id: user, soukai_id: 2).present?
    @mar = Attendance.where(user_id: user, soukai_id: 3).present?
    @apr = Attendance.where(user_id: user, soukai_id: 4).present?
    @may = Attendance.where(user_id: user, soukai_id: 5).present?
    @jun = Attendance.where(user_id: user, soukai_id: 6).present?
    @jul = Attendance.where(user_id: user, soukai_id: 7).present?
    @aug = Attendance.where(user_id: user, soukai_id: 8).present?
    @sep = Attendance.where(user_id: user, soukai_id: 9).present?
    @oct = Attendance.where(user_id: user, soukai_id: 10).present?
    @nov = Attendance.where(user_id: user, soukai_id: 11).present?
    @dec = Attendance.where(user_id: user, soukai_id: 12).present?
  end

  def set_month_jap
    @month_jap = []
    (1..12).each{ |i| @month_jap << i.to_s + "月" }
  end
  
  # def set_month_en
  #   @month_en = ["jan", "feb", "mar", "apr", "ay",
  #       "jun", "jul", "aug", "sep", "oct", "nov", "dec"]
  #       [:"1月" => "jan", :feb => "2月", :mar => "3月", : => "4月", : => "5月", : => "6月", : => "7月", : => "8月", : => "9月", : => "10月", : => "11月", : => "12月"]
  # end
  
end
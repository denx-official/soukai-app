module Common
  extend ActiveSupport::Concern

  def set_month_jap
    @month_jap = []
    (1..12).each{ |i| @month_jap << i.to_s + "月" }
  end
  
  # def set_month_en
  #   @month_en = ["jan", "feb", "mar", "apr", "ay",
  #       "jun", "jul", "aug", "sep", "oct", "nov", "dec"]
  #       [:"1月" => "jan", :feb => "2月", :mar => "3月", : => "4月", : => "5月", : => "6月", : => "7月", : => "8月", : => "9月", : => "10月", : => "11月", : => "12月"]
  # end

  private

  # privateメソッド

end
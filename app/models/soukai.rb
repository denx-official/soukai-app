class Soukai < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  belongs_to :attendance
  
  def Soukai.narrow_month(month)
    if Rails.env.development?
      Soukai.where("cast(strftime('%m', date) as int) = ?", month)
    else
      Soukai.where("extract(month from date) = ?", month)
    end
  end
  
  def Soukai.narrow_year(year)
    if Rails.env.development?
      Soukai.where("cast(strftime('%Y', date) as int) = ?", year)
    else
      Soukai.where("extract(year  from date) = ?", year)
    end
  end
  
end

class Attendance < ActiveRecord::Base
  has_many :user
  has_many :soukai
end

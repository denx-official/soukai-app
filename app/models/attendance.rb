class Attendance < ActiveRecord::Base
  has_many :user
  has_many :soukai
  # validates :user_id, :uniquness => {:scope => :soukai_id}
end

class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :soukai
  # validates :user_id, :uniquness => {:scope => :soukai_id}
end

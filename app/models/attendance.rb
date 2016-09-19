class Attendance < ActiveRecord::Base
  validates :soukai_id,  presence: true
  validates :user_id,  presence: true
  belongs_to :user
  belongs_to :soukai
  # validates :user_id, :uniquness => {:scope => :soukai_id}
end

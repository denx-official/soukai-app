class Attendance < ActiveRecord::Base
  validates :soukai_id,  presence: true
  validates :user_id,  presence: true, uniqueness: { scope: [:soukai_id] }
  belongs_to :user
  belongs_to :soukai
end

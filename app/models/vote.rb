class Vote < ActiveRecord::Base
  validates :project_id, presence: true
  validates :project_option_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: [:project_id] }
  belongs_to :project
  belongs_to :project_option
  belongs_to :user
end

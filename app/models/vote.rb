class Vote < ActiveRecord::Base
  validates :project_id, presence: true
  validates :project_option, presence: true, allow_nil: true
  validates :user_id, presence: true
  belongs_to :project
  belongs_to :project_option
  belongs_to :user
end

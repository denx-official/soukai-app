class Project < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  belongs_to :project_vote
  belongs_to :project_option
end

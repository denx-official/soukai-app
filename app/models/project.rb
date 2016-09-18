class Project < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :project_vote
  has_many :project_option, dependent: :destroy
  accepts_nested_attributes_for :project_option, allow_destroy: true
end

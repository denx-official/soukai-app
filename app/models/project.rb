class Project < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :soukai_id, presence: true
  validates :user_id, presence: true
  has_many :vote
  has_many :project_option, dependent: :destroy
  accepts_nested_attributes_for :project_option, allow_destroy: true
end

class Project < ActiveRecord::Base
  validates :name,      presence: true, length: { maximum: 100 }
  validates :soukai_id, presence: true
  validates :user_id,   presence: true
  has_many :vote, dependent: :destroy
  has_many :project_option, dependent: :destroy
  belongs_to :soukai
  accepts_nested_attributes_for :project_option, allow_destroy: true
end

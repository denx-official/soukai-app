class ProjectOption < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  belongs_to :project
end

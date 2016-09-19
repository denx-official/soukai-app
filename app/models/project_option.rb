class ProjectOption < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 1000000 }
  belongs_to :project
end

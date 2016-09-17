class ProjectVote < ActiveRecord::Base
  has_many :project
  has_many :user
end

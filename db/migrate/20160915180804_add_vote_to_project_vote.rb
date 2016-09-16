class AddVoteToProjectVote < ActiveRecord::Migration
  def change
    add_column :project_votes, :vote, :boolean
  end
end

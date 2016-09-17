class AddProjectOptionIdToProjectVotes < ActiveRecord::Migration
  def change
    add_column :project_votes, :project_option_id, :integer
  end
end

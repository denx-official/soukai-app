class RemoveOptionNumberFromProjectOptions < ActiveRecord::Migration
  def change
    remove_column :project_options, :option_number, :integer
  end
end

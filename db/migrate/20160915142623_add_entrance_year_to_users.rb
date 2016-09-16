class AddEntranceYearToUsers < ActiveRecord::Migration
  def change
    add_column :users, :entrance_year, :integer
  end
end

class CreateProjectOptions < ActiveRecord::Migration
  def change
    create_table :project_options do |t|
      t.integer :index
      t.string :name
      t.integer :price
      t.integer :project_id
      t.text :remarks

      t.timestamps null: false
    end
  end
end

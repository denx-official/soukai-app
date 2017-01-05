class CreateShareThings < ActiveRecord::Migration
  def change
    create_table :share_things do |t|
      t.string :name
      t.integer :content_type_id
      t.text :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

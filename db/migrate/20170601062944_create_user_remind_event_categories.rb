class CreateUserRemindEventCategories < ActiveRecord::Migration
  def change
    create_table :user_remind_event_categories do |t|
      t.integer :user_id
      t.integer :event_category_id
      t.boolean :is_remind, default: false
      t.integer :remind_before_day, default: 1
      
      t.timestamps null: false
    end
  end
end

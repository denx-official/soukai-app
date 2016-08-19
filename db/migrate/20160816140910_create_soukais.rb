class CreateSoukais < ActiveRecord::Migration
  def change
    create_table :soukais do |t|
      t.string :name
      t.date :date
      t.string :password_digest

      t.timestamps null: false
    end
  end
end

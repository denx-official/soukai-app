class CreateSoukais < ActiveRecord::Migration
  def change
    create_table :soukais do |t|
      t.int :month
      t.int :year
      t.string :password_digest

      t.timestamps null: false
    end
  end
end

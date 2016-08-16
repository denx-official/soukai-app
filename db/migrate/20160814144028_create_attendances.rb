class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.boolean :jan
      t.boolean :feb
      t.boolean :mar
      t.boolean :apr
      t.boolean :may
      t.boolean :jun
      t.boolean :jul
      t.boolean :aug
      t.boolean :sep
      t.boolean :oct
      t.boolean :nov
      t.boolean :dec

      t.timestamps null: false
    end
  end
end

class AddPasswordToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :password_digest, :string
  end
end

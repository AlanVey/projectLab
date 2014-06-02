class AddUserIdToProjectUser < ActiveRecord::Migration
  def change
    add_column :project_users, :user_id, :integer
  end
end

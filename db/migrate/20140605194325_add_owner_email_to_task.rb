class AddOwnerEmailToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :owner_email, :string
  end
end

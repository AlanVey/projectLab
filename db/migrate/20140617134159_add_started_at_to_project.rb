class AddStartedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :started_at, :date
  end
end

class AddProjectIdToEtherpad < ActiveRecord::Migration
  def change
    add_column :etherpads, :project_id, :integer
  end
end

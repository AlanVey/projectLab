class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :project_users do |t|
      t.string :email
      t.integer :project_id

      t.timestamps
    end
  end
end

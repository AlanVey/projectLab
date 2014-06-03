class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.date :due_date
      t.date :completion_date
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end

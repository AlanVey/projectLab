class CreateEtherpads < ActiveRecord::Migration
  def change
    create_table :etherpads do |t|
      t.string :name
      t.string :file
      t.string :creator

      t.timestamps
    end
  end
end

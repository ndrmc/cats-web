class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.integer :program_id
      t.integer :hrd_id
      t.integer :fscd_annual_plan_id
      t.string :name, null: false
      t.text :descripiton
      t.string :year
      t.integer :round
      t.integer :month
      t.date :expected_start
      t.date :expected_end
      t.date :actual_start
      t.date :actual_end
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

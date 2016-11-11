class CreateRationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :ration_items do |t|
      t.decimal :amount, null: false
      t.integer :ration_id
      t.integer :unit_of_measure_id
      t.timestamps
    end
  end
end

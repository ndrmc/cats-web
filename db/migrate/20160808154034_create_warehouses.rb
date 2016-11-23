class CreateWarehouses < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouses do |t|
      t.string :name, null: false
      t.string :description
      t.integer :hub_id
      t.integer :location_id
      t.integer :organization_id
      t.decimal :lat
      t.decimal :lon
      t.timestamps
    end
  end
end

class CreateWarehouses < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouses do |t|
      t.string :name, null: false
      t.string :description
      t.integer :hub_id
      t.integer :location_id
      t.integer :organization_id
      t.decimal :lat,  precision: 15, scale: 13
      t.decimal :lon,  precision: 15, scale: 13
      t.timestamps
    end
  end
end

class CreateStoreLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :store_locations do |t|
      t.string :name, null: false
      t.string :description
      t.integer :hub_id
      t.integer :location_id
      
      t.timestamps
    end
  end
end

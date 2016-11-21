class CreateHubs < ActiveRecord::Migration[5.0]
  def change
    create_table :hubs do |t|
      t.string :name, null: false
      t.string :description
      t.float :lat
      t.float :lon
      t.integer :location_id

      t.timestamps
    end

    add_index :hubs, :name, :unique => true
  end
end

class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :code
      t.integer :location_type_id      

      t.timestamps
    end
  end
end

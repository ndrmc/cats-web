class CreateFdps < ActiveRecord::Migration[5.0]
  def change
    create_table :fdps do |t|
      t.string :name, null: false
      t.string :description
      t.float :lat
      t.float :lon
      t.boolean :active
      t.integer :location_id
      
      t.timestamps
    end
  end
end

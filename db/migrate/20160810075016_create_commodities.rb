class CreateCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :commodities do |t|
      t.string :name, null: false
      t.string :name_am
      t.string :long_name
      t.string :code, null: false
      t.string :code_am
      t.text :description
      t.boolean :hazardous
      t.boolean :cold_storage
      t.float :min_temperature
      t.float :mix_temperature
      t.integer :commodity_category_id
      t.integer :unit_of_measure_id

      t.timestamps
    end

    add_index :commodities, :code, :unique => true
  end
end

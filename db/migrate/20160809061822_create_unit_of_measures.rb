class CreateUnitOfMeasures < ActiveRecord::Migration[5.0]
  def change
    create_table :unit_of_measures do |t|
      t.string :name, null: false
      t.string :description
      t.string :code, null: false
      t.integer :uom_type, default: 0, null: false
      t.decimal :ratio, precision: 8, scale: 2, null: false
      t.integer :uom_category_id

      t.timestamps
    end
    add_index :unit_of_measures, :code, :unique => true
  end
end

class CreateStockMovements < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_movements do |t|
      t.integer :source_hub_id
      t.integer :source_warehouse_id
      t.integer :source_store_id
      t.integer :destination_hub_id
      t.integer :destination_warehouse_id
      t.integer :destination_store_id
      t.references :project, foreign_key: true
      t.references :commodity, foreign_key: true
      t.decimal :quantity, :precision => 8, :scale => 2
      t.string :description

      t.timestamps
    end
  end
end

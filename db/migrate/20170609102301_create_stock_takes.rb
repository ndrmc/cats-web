class CreateStockTakes < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_takes do |t|
      t.string  :title, null: false
      t.integer :hub_id, null: false
      t.integer :warehouse_id, null: false
      t.integer :store_no     
      t.date :date, null: false
      t.integer :fiscal_period
      t.boolean :draft, default: true
      

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

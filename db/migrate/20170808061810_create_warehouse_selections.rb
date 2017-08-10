class CreateWarehouseSelections < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouse_selections do |t|
      t.integer :framework_tender_id
      t.integer :woreda_id
      t.integer :warehouse_id
      t.decimal :estimated_qty
      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

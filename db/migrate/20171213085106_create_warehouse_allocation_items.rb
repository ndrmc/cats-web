class CreateWarehouseAllocationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouse_allocation_items do |t|
      t.integer :warehouse_allocation_id
      t.integer :zone_id
      t.integer :woreda_id
      t.integer :fdp_id
      t.integer :hub_id
      t.integer :warehouse_id
      t.integer :requisition_id
      t.integer :status
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

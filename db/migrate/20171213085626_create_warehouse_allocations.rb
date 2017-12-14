class CreateWarehouseAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouse_allocations do |t|
      t.integer :operation_id
      t.integer :region_id
      t.integer :status
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

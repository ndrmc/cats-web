class CreateFdpOperationsLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :fdp_operations_logs do |t|

      t.integer :operation_id
      t.string :operation_name
      t.integer :fdp_id
      t.string :fdp_name
      t.integer :woreda_id
      t.string :woreda_name
      t.integer :zone_id
      t.string :zone_name
      t.integer :region_id
      t.string :region_name
      t.integer :requisition_id
      t.string :requisition_no
      t.integer :commodity_id
      t.string :commodity_name
      t.decimal :allocated_in_mt
      t.decimal :dispatched_in_mt
      t.decimal :delivered_in_mt
      t.decimal :distributed_in_mt
      t.boolean :deleted, :default => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

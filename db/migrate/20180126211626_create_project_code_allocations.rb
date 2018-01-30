class CreateProjectCodeAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :project_code_allocations do |t|
      t.integer :hub_id
      t.integer :warehouse_id
      t.integer :store_id
      t.integer :operation_id
      t.integer :requisition_id
      t.decimal :amount
      t.integer :unit_of_measure_id
      t.integer :fdp_id
      t.integer :project_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

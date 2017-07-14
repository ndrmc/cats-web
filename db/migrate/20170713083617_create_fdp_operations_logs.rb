class CreateFdpOperationsLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :fdp_operations_logs do |t|

		t.references :operation

    	t.references :fdp

    	t.references :location

    	t.references :requisition

    	t.references :commodity

    	t.decimal :allocated_in_mt

    	t.decimal :dispatched_in_mt

    	t.decimal :delivered_in_mt

    	t.decimal :distributed_in_mt

      	t.timestamps
    end
  end
end

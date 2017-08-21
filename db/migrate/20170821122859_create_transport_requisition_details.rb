class CreateTransportRequisitionDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :transport_requisition_details do |t|
      t.integer :transport_requisition_id
      t.integer :requisition_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

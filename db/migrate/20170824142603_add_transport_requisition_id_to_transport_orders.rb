class AddTransportRequisitionIdToTransportOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :transport_orders, :transport_requisition_id, :integer
  end
end

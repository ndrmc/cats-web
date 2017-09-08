class RemoveTransportRequisitionIdFromTo < ActiveRecord::Migration[5.0]
  def up
  	if column_exists?(:transport_orders, :transport_requisition_id)
		remove_column :transport_orders, :transport_requisition_id, :integer
	end
  end

  def down
  	if ! column_exists?(:transport_orders, :transport_requisition_id)
		add_column :transport_orders, :transport_requisition_id, :integer
	end
  end
end

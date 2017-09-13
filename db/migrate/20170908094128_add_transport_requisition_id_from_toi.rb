class AddTransportRequisitionIdFromToi < ActiveRecord::Migration[5.0]
  def up
  	if ! column_exists?(:transport_order_items, :transport_requisition_item_id)
  		add_column :transport_order_items, :transport_requisition_item_id, :integer		
	end
  end

  def down
  	if column_exists?(:transport_order_items, :transport_requisition_item_id)
		remove_column :transport_order_items, :transport_requisition_item_id, :integer
	end
  end
end

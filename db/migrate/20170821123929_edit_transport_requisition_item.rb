class EditTransportRequisitionItem < ActiveRecord::Migration[5.0]
  def up
  	if column_exists?(:transport_requisition_items, :transport_requisition_item_id)
		rename_column :transport_requisition_items, :transport_requisition_item_id, :transport_requisition_id
	end
	if column_exists?(:transport_requisition_items, :requisition_no)
		rename_column :transport_requisition_items, :requisition_no, :requisition_id
	end
  end

  def down
  	if column_exists?(:transport_requisition_items, :transport_requisition_id)
		rename_column :transport_requisition_items, :transport_requisition_id, :transport_requisition_item_id
	end
	if column_exists?(:transport_requisition_items, :requisition_id)
		rename_column :transport_requisition_items, :requisition_id, :requisition_no
	end
  end
end
																																																																						
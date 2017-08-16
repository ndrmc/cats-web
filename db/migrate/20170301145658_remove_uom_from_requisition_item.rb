class RemoveUomFromRequisitionItem < ActiveRecord::Migration[5.0]
  def change
  	remove_column :requisition_items, :commodity_id
    remove_column :requisition_items, :unit_of_measure_id
	
  end
end

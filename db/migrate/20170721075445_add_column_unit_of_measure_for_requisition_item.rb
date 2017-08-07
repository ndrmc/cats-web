class AddColumnUnitOfMeasureForRequisitionItem < ActiveRecord::Migration[5.0]
  def change
  	add_column :requisition_items, :unit_of_measure_id, :integer
  end
end

class AddColumnUnitOfMeasureForRequisitionItem < ActiveRecord::Migration[5.0]
  def change
  	add_reference :requisition_items, :unit_of_measures, foreign_key: true
  end
end

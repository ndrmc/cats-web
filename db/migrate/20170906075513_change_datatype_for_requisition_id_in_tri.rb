class ChangeDatatypeForRequisitionIdInTri < ActiveRecord::Migration[5.0]
  def up
  	change_column :transport_requisition_items, :requisition_id, 'integer USING CAST(requisition_id AS integer)'
  end
  def down
  	change_column :transport_requisition_items, :requisition_id, 'character varying USING CAST(requisition_id AS character varying)'
  end
end

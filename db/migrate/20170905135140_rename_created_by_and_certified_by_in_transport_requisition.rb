class RenameCreatedByAndCertifiedByInTransportRequisition < ActiveRecord::Migration[5.0]
  def up
  	if column_exists?(:transport_requisitions, :created_by)
		rename_column :transport_requisitions, :created_by, :created_by_id
	end
	if column_exists?(:transport_requisitions, :certified_by)
		rename_column :transport_requisitions, :certified_by, :certified_by_id
	end
  end

  def down
  	if column_exists?(:transport_requisitions, :created_by_id)
		rename_column :transport_requisitions, :created_by_id, :created_by
	end
	if column_exists?(:transport_requisitions, :certified_by_id)
		rename_column :transport_requisitions, :certified_by_id, :certified_by
	end
  end
end

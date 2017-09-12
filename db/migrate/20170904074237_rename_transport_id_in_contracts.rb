class RenameTransportIdInContracts < ActiveRecord::Migration[5.0]
  def up
  	if column_exists?(:contracts, :transport_id)
		rename_column :contracts, :transport_id, :transporter_id
	end
  end

  def down
  	if column_exists?(:contracts, :transporter_id)
		rename_column :contracts, :transporter_id, :transport_id
	end
  end
end

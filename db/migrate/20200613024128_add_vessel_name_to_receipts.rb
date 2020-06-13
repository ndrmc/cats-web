class AddVesselNameToReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :vessel_name, :string
  end
end

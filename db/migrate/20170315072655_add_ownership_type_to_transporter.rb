class AddOwnershipTypeToTransporter < ActiveRecord::Migration[5.0]
  def change
    remove_column :transporters, :ownership
    add_column :transporters, :ownership_type_id, :integer
  end
end

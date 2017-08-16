class AddAddressToWarehouse < ActiveRecord::Migration[5.0]
  def change
    add_column :warehouses, :address, :string
  end
end

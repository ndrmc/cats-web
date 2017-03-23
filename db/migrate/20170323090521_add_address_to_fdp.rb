class AddAddressToFdp < ActiveRecord::Migration[5.0]
  def change
    add_column :fdps, :address, :string
  end
end

class AddAddressToHub < ActiveRecord::Migration[5.0]
  def change
    add_column :hubs, :address, :string
  end
end

class AddStoreKeeperNameToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :store_keeper_name, :string
  end
end

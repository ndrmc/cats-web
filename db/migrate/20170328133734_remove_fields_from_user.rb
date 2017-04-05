class RemoveFieldsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :hub_user,     :boolean
    remove_column :users, :hub,          :string
    remove_column :users, :region,       :string
  end
end

class RemoveFieldsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :is_case_team, :boolean
    remove_column :users, :is_admin,     :boolean
    remove_column :users, :case_team,    :integer
    remove_column :users, :hub_user,     :boolean
    remove_column :users, :regional_user,:boolean
    remove_column :users, :role_types_id,:integer
    remove_column :users, :hub,          :string
    remove_column :users, :region,       :string
  end
end

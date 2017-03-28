class RemoveFieldsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :is_case_team
    remove_column :users, :is_admin
    remove_column :users, :case_team
    remove_column :users, :hub_user
    remove_column :users, :regional_user
    remove_column :users, :role_types_id
  end
end

class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :date_preference, :date
    add_column :users, :mobile_no, :string
    add_column :users, :regional_user, :boolean
    add_column :users, :hub_user, :boolean
    add_column :users, :case_team, :integer
    add_column :users, :is_admin, :boolean
    add_column :users, :is_case_team, :boolean
  end
end

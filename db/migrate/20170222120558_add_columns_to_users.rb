class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :datePreference, :date
    add_column :users, :mobileNo, :string
    add_column :users, :numberOfLogins, :integer
    add_column :users, :regionalUser, :boolean
    add_column :users, :hubUser, :boolean
    add_column :users, :role, :integer
  end
end

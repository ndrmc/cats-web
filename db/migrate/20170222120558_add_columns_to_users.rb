class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :date_preference, :date
    add_column :users, :mobile_no, :string
    add_column :users, :number_of_logins, :integer
    add_column :users, :region_user, :boolean
    add_column :users, :hub_user, :boolean    
  end
end

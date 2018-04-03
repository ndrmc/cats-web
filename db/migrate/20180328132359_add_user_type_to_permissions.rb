class AddUserTypeToPermissions < ActiveRecord::Migration[5.0]
  def change
    add_column :permissions, :user_type, :integer
  end
end

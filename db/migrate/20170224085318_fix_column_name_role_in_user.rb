class FixColumnNameRoleInUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :role, :case_team
  end
end

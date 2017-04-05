class RenameUserTypeIdToUserType < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :user_type_id, :user_types
  end
end

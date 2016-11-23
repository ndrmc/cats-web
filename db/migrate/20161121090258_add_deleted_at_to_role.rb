class AddDeletedAtToRole < ActiveRecord::Migration[5.0]
  def change
  	add_column :roles, :deleted_at, :datetime
	add_index :roles, :deleted_at  	
	add_column :users_roles, :deleted_at, :datetime
	add_index :users_roles, :deleted_at
  end
end

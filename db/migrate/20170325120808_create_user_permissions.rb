class CreateUserPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :users_permissions do |t|
      t.references :user, foreign_key: true
      t.references :permission, foreign_key: true
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

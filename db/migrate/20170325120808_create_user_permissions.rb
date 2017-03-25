class CreateUserPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_permissions do |t|
      t.references :user, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end

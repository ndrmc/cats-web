class CreateDepartmentPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :department_permissions do |t|
      t.references :department, foreign_key: true
      t.references :permission, foreign_key: true
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps

    end
  end
end

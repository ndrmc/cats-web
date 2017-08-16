class CreateUsersDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :users_departments do |t|
      t.references :user, foreign_key: true
      t.references :department, foreign_key: true
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

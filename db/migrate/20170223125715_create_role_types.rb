class CreateRoleTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :role_types do |t|
      t.string :name
      t.string :description

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

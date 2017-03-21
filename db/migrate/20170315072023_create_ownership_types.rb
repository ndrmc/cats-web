class CreateOwnershipTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :ownership_types do |t|
      t.string :name, null: false
      t.text :description

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

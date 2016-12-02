class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.boolean :temporary
      t.integer :warehouse_id

      t.timestamps
    end

    add_index :stores, [:name, :warehouse_id], :unique => true
  end
end

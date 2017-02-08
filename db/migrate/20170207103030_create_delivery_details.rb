class CreateDeliveryDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_details do |t|
      t.integer :commodity_id
      t.integer :uom_id
      t.decimal :sent_quantity
      t.decimal :recieved_quantity
      t.integer :delivery_id

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

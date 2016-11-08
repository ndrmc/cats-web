class CreateTransportOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :transport_order_items do |t|
      t.integer :transport_order_id
      t.integer :fdp_id
      t.integer :store_id
      t.integer :commodity_id
      t.decimal :quantity
      t.integer :unit_of_measure_id
      t.decimal :tariff
      t.string :requisition_no
      
      t.timestamps
    end
  end
end

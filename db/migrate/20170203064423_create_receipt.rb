class CreateReceipt < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts do |t|

      t.string :grn_no, null: false 
      t.datetime :received_date 
      t.references :hub
      t.references :warehouse
      t.string :delivered_by 
      t.references :supplier 
      t.references :transporter
      t.string :plate_no 
      t.string :trailer_plate_no 
      t.string :weight_bridge_ticket_no 
      t.decimal :weight_before_unloading
      t.decimal :weight_after_unloading
      t.string :storekeeper_name
      t.string :waybill_no
      t.string :purchase_request_no
      t.string :purchase_order_no
      t.string :invoice_no

      t.references :commodity_source
      t.references :program 
      t.references :store 

      t.string :drivers_name 

      t.text :remark 

      t.boolean :draft, :default => false 


     t.integer :created_by
     t.integer :modified_by
     t.boolean :deleted, :default => false
     t.datetime :deleted_at

     t.timestamps 
    end
  end
end

class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|

      t.string :delivery_id
      t.string :receiving_number
      t.integer :donor_id
      t.integer :transporter_id
      t.string :primary_plate_number
      t.string :trailer_plate_number
      t.string :driver_name
      t.integer :fdp_id
      t.integer :dispatch_id
      t.string :waybill_number
      t.string :requisition_number
      t.integer :hub_id
      t.string :invoice_number
      t.string :delivery_by
      t.date :delivery_date
      t.string :received_by
      t.date :receive_date
      t.string :document_received_date
      t.date :document_received_date
      t.integer :status
      t.integer :action_type
      t.text :action_type_remark
      t.integer :pisting_id

      t.timestamps
    end
  end
end

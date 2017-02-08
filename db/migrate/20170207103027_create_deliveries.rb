class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|

      t.string :receiving_number
     
      t.integer :transporter_id
      t.string :primary_plate_number
      t.string :trailer_plate_number
      t.string :driver_name
      t.integer :fdp_id
      t.integer :gin_number
      t.string :waybill_number
      t.string :requisition_number     
      t.string :received_by
      t.date :received_date     
      t.integer :status     
      t.integer :operation_id

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at


      t.timestamps
    end
  end
end

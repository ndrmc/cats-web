class CreateDeliveryImports < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_imports do |t|
      t.string :transporter_ref_no
      t.string :grn
      t.string :requisition_no
      t.string :received_by
      t.string :received_date
      t.string :delivery_date
      t.string :quantity_received_qtl
      t.string :prepared_date
      t.string :prepared_by
      t.string :gin
      t.string :dispatch_date
      t.string :region
      t.string :origin_warehouse
      t.string :zone
      t.string :woreda
      t.string :destination
      t.string :allocation_month
      t.string :allocation_year
      t.string :round
      t.string :program
      t.string :commodity_type
      t.string :sub_commodity
      t.string :unit_type
      t.string :allocation_quantity
      t.string :dispatch_quantity      
      t.string :donor
      t.string :si_number
      t.string :transporter_name
      t.string :received_by
      t.string :plate_no
      t.string :trailer_no
      t.string :driver_license
      t.string :hub_storekeeper
      t.string :project_code
      t.string :ltcd_no

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

class CreateGrnImports < ActiveRecord::Migration[5.0]
  def change
    create_table :grn_imports do |t|
      t.string :hub
      t.string :warehouse
      t.string :storekeeper
      t.string :received_date
      t.string :donor
      t.string :supplier
      t.string :origin
      t.string :si_donor
      t.string :project_code
      t.string :grn
      t.string :waybill_no
      t.string :commodity_class
      t.string :commodity_type
      t.string :total_units_received
      t.string :unit_weight
      t.string :sent_mt # The value is not in Mt but rather Qtl even if the field name says 'mt'
      t.string :received_in_bag
      t.string :received_in_mt
      t.string :vessel_name
      t.string :transporter_name
      t.string :plat_no
      t.string :trailer_no
      
      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

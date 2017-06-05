class CreateGitImports < ActiveRecord::Migration[5.0]
  def change
    create_table :git_imports do |t|    	      
      t.string :gin
      t.string :hub
      t.string :requisition_no
      t.string :round
      t.string :region
      t.string :zone
      t.string :woreda 
      t.string :fdp
      t.string :transporter
      t.string :driver
      t.string :plat_no
      t.string :trailer_no
      t.string :dispatch_date
      t.string :project_code
      t.string :commodity_class
      t.string :commodity_type
      t.string :rounded_allocation_mt
      t.string :total_units_dispatched
      t.string :quintals_dispatched
      t.string :mt_dispatched
      t.string :allocation_period
      t.string :storekeeper
      t.string :store_no
      t.string :remark

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

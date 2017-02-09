class CreateDispatches < ActiveRecord::Migration[5.0]
  def change
    create_table :dispatches do |t|
      t.string :gin_no, null: false 
      t.references :operation 

      t.string :requisition_number 
      t.datetime :dispatch_date 

      t.references :fdp 
      t.string :weight_bridge_ticket_number

      t.references :transporter 

      t.string :plate_number 
      t.string :trailer_plate_number 
      
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

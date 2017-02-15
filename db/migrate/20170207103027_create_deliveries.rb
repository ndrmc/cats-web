class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|

      t.string :receiving_number  ,  null: false   
      t.integer :transporter_id ,  null: false     
      t.integer :fdp_id, null: false 
      t.integer :gin_number ,  null: false     
      t.string :requisition_number ,  null: false     
      t.string :received_by,  null: false 
      t.date :received_date ,  null: false     
      t.integer :status     
      t.integer :operation_id
      t.text  :remark

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at


      t.timestamps
    end
    add_index :deliveries, :receiving_number, :unique => true
    add_index :deliveries, :gin_number, :unique => true
  end
end

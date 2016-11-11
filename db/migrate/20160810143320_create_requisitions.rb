class CreateRequisitions < ActiveRecord::Migration[5.0]
  def change
    create_table :requisitions do |t|
      t.string :requisition_no, null: false
      t.integer :operation_id
      t.integer :commodity_id
      t.integer :region_id
      t.integer :zone_id
      t.integer :ration_id
      t.string :requested_by
      t.date :requested_on
      t.integer :status, default: 0, null: false
      t.timestamps
    end

    add_index :requisitions, :requisition_no, :unique => true
  end
end

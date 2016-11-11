class CreateTransportRequisitions < ActiveRecord::Migration[5.0]
  def change
    create_table :transport_requisitions do |t|
      t.integer :region_id
      t.integer :operation_id      
      t.date :created_date
      t.text :description

      t.timestamps
    end
  end
end

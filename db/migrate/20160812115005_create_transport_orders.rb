class CreateTransportOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :transport_orders do |t|
      t.string :order_no
      t.integer :transporter_id
      t.integer :contract_id
      t.integer :bid_id
      t.integer :operation_id
      t.integer :region_id
      t.date :order_date
      t.date :created_date
      t.date :start_date
      t.date :end_date
      t.string :performance_bond_receipt
      t.decimal :performance_bond_amount
      t.integer :printed_copies, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

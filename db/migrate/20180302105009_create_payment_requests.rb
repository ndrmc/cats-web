class CreatePaymentRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_requests do |t|
      t.references :transporter, foreign_key: true
      t.string :reference_no
      t.decimal :amount_requested, precision: 10, scale: 2
      t.string :remark
      t.integer :status
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :payment_requests, :reference_no, unique: true
  end
end

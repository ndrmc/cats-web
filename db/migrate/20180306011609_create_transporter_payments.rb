class CreateTransporterPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :transporter_payments do |t|
      t.references :payment_request, foreign_key: true
      t.string :chequeNo
      t.string :voucherNo
      t.string :bankName
      t.decimal :paidAmount, precision: 10, scale: 2
      t.datetime :paymentDate
      t.integer :status
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

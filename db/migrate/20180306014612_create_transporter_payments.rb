class CreateTransporterPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :transporter_payments do |t|
      t.references :payment_request, foreign_key: true
      t.string :cheque_no
      t.string :voucher_no
      t.string :bank_name
      t.decimal :paid_amount, precision: 10, scale: 2
      t.string :prepared_by
      t.string :approved_by
      t.string :approved_date
      t.string :datetime
      t.datetime :payment_date
      t.integer :status
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

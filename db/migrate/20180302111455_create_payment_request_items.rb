class CreatePaymentRequestItems < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_request_items do |t|
      t.references :payment_request, foreign_key: true
      t.string :requisition_no
      t.integer :gin_no
      t.integer :grn_no
      t.references :commodity, foreign_key: true
      t.references :hub, foreign_key: true
      t.references :fdp, foreign_key: true
      t.decimal :dispatched, precision: 10, scale: 2
      t.decimal :received, precision: 10, scale: 2
      t.decimal :loss, precision: 10, scale: 2
      t.decimal :tariff, precision: 10, scale: 2
      t.decimal :freightCharge, precision: 10, scale: 2
      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

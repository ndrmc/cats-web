class CreateGiftCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :gift_certificates do |t|
      t.string :reference_no, null: false
      t.date :gift_date
      t.string :vessel
      t.integer :donor_id
      t.date :eta
      t.integer :program_id
      t.integer :mode_of_transport_id
      t.string :port_name
      t.integer :status, default: 0, null: false
      t.string :customs_declaration_no
      t.string :bill_of_ladding
      t.float :amount
      t.float :estimated_price
      t.float :estimated_tax
      t.string :purchase_year
      t.date :expiry_date
      t.integer :fund_type_id
      t.string :account_no
      t.timestamps
    end

    add_index :gift_certificates, :reference_no, :unique => true
  end
end

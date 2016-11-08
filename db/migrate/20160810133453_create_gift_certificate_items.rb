class CreateGiftCertificateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :gift_certificate_items do |t|
      t.integer :gift_certificate_id
      t.integer :commodity_id
      t.integer :fund_source_id
      t.integer :unit_of_measure_id
      t.integer :currency_id
      t.float :amount, null: false
      t.float :estimated_value
      t.float :estimated_tax
      t.date :expiry_date
      
      t.timestamps
    end
  end
end

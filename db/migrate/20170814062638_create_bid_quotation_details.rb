class CreateBidQuotationDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :bid_quotation_details do |t|
      t.references :bid_quotation, foreign_key: true
      t.references :warehouse, foreign_key: true
      t.references :location, foreign_key: true
      t.decimal :tariff
      t.text :remark

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

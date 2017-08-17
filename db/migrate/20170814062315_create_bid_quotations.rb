class CreateBidQuotations < ActiveRecord::Migration[5.0]
  def change
    create_table :bid_quotations do |t|
      t.references :bid, foreign_key: true
      t.references :transporter, foreign_key: true
      t.date :bid_quotation_date

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

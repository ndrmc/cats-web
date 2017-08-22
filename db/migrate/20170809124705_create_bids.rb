class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.integer :framework_tender_id
      t.integer :region_id
      t.string :bid_number
      t.decimal :bid_bond_amount, precision:15, scale: 3
      t.date :start_date
      t.date :closing_date
      t.date :opening_date
      t.integer :status
      t.text :remark

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

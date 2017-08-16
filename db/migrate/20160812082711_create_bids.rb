class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.string :bid_no, null: false
      t.date :start_date
      t.date :end_date
      t.text :description
      t.date :opening_date
      t.integer :status, default: 0, null: false
      t.integer :bid_plan_id
      t.integer :region_id
      t.decimal :document_price
      t.decimal :cpo_deposit_amount
      
      t.timestamps
    end
  end
end

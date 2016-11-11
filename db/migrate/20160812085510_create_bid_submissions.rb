class CreateBidSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :bid_submissions do |t|
      t.integer :bid_id
      t.integer :transporter_id
      t.decimal :bid_bond_amount      
      t.timestamps
    end
  end
end

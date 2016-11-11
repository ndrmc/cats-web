class CreateBidWinners < ActiveRecord::Migration[5.0]
  def change
    create_table :bid_winners do |t|
      t.integer :bid_id
      t.integer :transporter_id
      t.integer :store_id
      t.integer :destination_id
      t.decimal :tariff_amount
      t.timestamps
    end
  end
end

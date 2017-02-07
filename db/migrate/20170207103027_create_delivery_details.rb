class CreateBidPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :bid_plans do |t|
      t.integer :commodity_id
      t.integer :uom_id
      t.decimal :sent_quantity
      t.decimal :recieved_quantity
      t.integer :delivery_id
      t.timestamps
    end
  end
end

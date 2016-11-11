class CreateBidPlanItems < ActiveRecord::Migration[5.0]
  def change
    create_table :bid_plan_items do |t|
      t.integer :bid_plan_id
      t.integer :woreda_id
      t.integer :store_id
      t.decimal :quantity
      t.integer :unit_of_measure_id

      t.timestamps
    end
  end
end

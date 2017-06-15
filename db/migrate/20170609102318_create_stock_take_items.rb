class CreateStockTakeItems < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_take_items do |t|
      t.integer :commodity_id, null: false
      t.integer :commodity_category_id, null: false
      t.decimal :theoretical_amount, null: false
      t.decimal :actual_amount, null: false
      t.integer :stock_take_id, null: false

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at
      t.timestamps
    end
  end
end

class CreateAdjustments < ActiveRecord::Migration[5.0]
  def change
    create_table :adjustments do |t|
      t.integer :stock_take_id, null: false
      t.integer :stock_take_item_id, null: false
      t.integer :commodity_id, null: false
      t.integer :commodity_category_id, null: false
      t.decimal :amount, null: false
      t.integer  :adjustment_type, null: false
      t.string  :reason

      t.integer :created_by
      t.integer :modified_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

class CreateFscdPlanItems < ActiveRecord::Migration[5.0]
  def change
    create_table :fscd_plan_items do |t|
      t.integer :beneficiary_no, null: false
      t.integer :fscd_annual_plan_id
      t.integer :woreda_id, null: false
      t.integer :starting_month
      t.integer :food_ratio
      t.integer :cash_ratio
      t.boolean :contingency
      t.timestamps
    end
  end
end

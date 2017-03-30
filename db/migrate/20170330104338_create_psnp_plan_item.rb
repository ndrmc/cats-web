class CreatePsnpPlanItem < ActiveRecord::Migration[5.0]
  def change
    create_table :psnp_plan_items do |t|

      t.integer  "psnp_plan_id"
      t.integer  "woreda_id"
      t.integer  "duration"
      t.integer  "starting_month"
      t.integer  "beneficiary"
      t.integer  "region_id"
      t.integer  "zone_id"

      t.integer  "created_by"
      t.integer  "modified_by"
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps

    end
  end
end

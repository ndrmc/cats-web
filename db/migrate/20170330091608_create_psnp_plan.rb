class CreatePsnpPlan < ActiveRecord::Migration[5.0]
  def change
    create_table :psnp_plans do |t|
      t.integer  "year_gc",                 null: false
      t.integer  "year_ec"
      t.integer  "status",      default: 0, null: false
      t.integer  "month_from"
      t.integer  "duration"
      t.integer  "ration_id"

      t.integer  "created_by"
      t.integer  "modified_by"
      t.boolean :deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index(:psnp_plans, :year_gc)
  end
end

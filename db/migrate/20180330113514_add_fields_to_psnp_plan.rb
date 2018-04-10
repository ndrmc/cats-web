class AddFieldsToPsnpPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :psnp_plan_items, :duration_public_work, :integer
    add_column :psnp_plan_items, :beneficiary_public_work, :integer
    add_column :psnp_plan_items, :cash_ratio_public_work, :integer
    add_column :psnp_plan_items, :kind_ratio_beneficiary_public_work, :integer
  end
end

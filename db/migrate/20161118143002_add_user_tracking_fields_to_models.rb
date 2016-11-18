class AddUserTrackingFieldsToModels < ActiveRecord::Migration[5.0]
  def change

  	tables [:account, :bid, :bid_plan, :bid_plan_item]

  	add_column :account, :created_by, :integer
  	add_column :acctount, :modified_by, :integer
  	add_column :account, :deleted, :boolean, :default => false
  end
end

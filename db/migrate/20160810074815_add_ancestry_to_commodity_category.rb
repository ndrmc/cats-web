class AddAncestryToCommodityCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :commodity_categories, :ancestry, :string
    add_index :commodity_categories, :ancestry
  end
end

class AddUomCategoryToCommodityCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :commodity_categories, :uom_category, foreign_key: true
  end
end

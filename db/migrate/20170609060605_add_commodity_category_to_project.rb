class AddCommodityCategoryToProject < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :commodity_categories, foreign_key: true
  end
end

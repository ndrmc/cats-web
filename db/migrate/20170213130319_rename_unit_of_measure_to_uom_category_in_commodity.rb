class RenameUnitOfMeasureToUomCategoryInCommodity < ActiveRecord::Migration[5.0]
  def change
    rename_column :commodities, :unit_of_measure_id, :uom_category_id
  end
end

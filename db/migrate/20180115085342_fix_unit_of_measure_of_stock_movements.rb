class FixUnitOfMeasureOfStockMovements < ActiveRecord::Migration[5.0]
  def change
    rename_column :stock_movements, :unit_of_measures_id, :unit_of_measure_id
  end
end

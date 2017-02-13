class AddUnitOfMeasureToCommodityCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :commodity_categories, :unit_of_measure, foreign_key: true
  end
end

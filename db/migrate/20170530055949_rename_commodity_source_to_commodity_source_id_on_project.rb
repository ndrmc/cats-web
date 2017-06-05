class RenameCommoditySourceToCommoditySourceIdOnProject < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :commodity_source, :commodity_source_id
  end
end

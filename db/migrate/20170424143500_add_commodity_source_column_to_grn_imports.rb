class AddCommoditySourceColumnToGrnImports < ActiveRecord::Migration[5.0]
  def change
    add_column :grn_imports, :commodity_source, :string
  end
end

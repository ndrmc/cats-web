class AddCodeToCommoditySource < ActiveRecord::Migration[5.0]
  def change
    add_column :commodity_sources, :code, :string
  end
end

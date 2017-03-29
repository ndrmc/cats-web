class AddRegionIdToHrdItem < ActiveRecord::Migration[5.0]
  def change
    add_column :hrd_items, :region_id, :integer
  end
end

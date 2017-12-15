class AddHubsToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :warehouse_id, :integer
  end
end

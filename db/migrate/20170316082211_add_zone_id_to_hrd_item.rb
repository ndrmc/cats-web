class AddZoneIdToHrdItem < ActiveRecord::Migration[5.0]
  def change
    add_column :hrd_items, :zone_id, :integer
  end
end

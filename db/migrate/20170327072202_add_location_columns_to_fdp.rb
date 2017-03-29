class AddLocationColumnsToFdp < ActiveRecord::Migration[5.0]
  def change
    add_column :fdps, :woreda, :string
    add_column :fdps, :zone, :string
    add_column :fdps, :region, :string
  end
end

class ChangeLongitudeAndLatitudeToDecimalOnFdp < ActiveRecord::Migration[5.0]
  def change
    change_column :fdps, :lat, :decimal, :precision => 15, :scale => 13
    change_column :fdps, :lon, :decimal, :precision => 15, :scale => 13
  end
end

class AddHideColumnToFdp < ActiveRecord::Migration[5.0]
  def change
     add_column :fdps, :hide_fdp, :boolean, default: false
  end
end

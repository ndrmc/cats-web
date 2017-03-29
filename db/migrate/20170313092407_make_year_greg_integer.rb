class MakeYearGregInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :hrds, :year_gc, 'integer USING CAST(year_gc AS integer)'
  end
end

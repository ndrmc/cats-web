class MakeYearGregInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :hrds, :year_greg, 'integer USING CAST(year_greg AS integer)'
  end
end

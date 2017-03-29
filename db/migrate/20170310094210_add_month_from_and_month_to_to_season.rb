class AddMonthFromAndMonthToToSeason < ActiveRecord::Migration[5.0]
  def change
    add_column :seasons, :month_from, :integer
    add_column :seasons, :month_to, :integer
  end
end

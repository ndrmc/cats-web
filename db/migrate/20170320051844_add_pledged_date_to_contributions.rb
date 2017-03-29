class AddPledgedDateToContributions < ActiveRecord::Migration[5.0]
  def change
    add_column :contributions, :pledged_date, :datetime
  end
end

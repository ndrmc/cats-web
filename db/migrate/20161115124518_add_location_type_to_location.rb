class AddLocationTypeToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :location_type, :integer
  end
end

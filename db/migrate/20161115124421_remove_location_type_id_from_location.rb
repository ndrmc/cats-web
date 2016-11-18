class RemoveLocationTypeIdFromLocation < ActiveRecord::Migration[5.0]
  def change
    remove_column :locations, :location_type_id, :integer
  end
end

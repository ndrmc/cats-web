class AddUomIdToDispatchItems < ActiveRecord::Migration[5.0]
  def change
    add_column :dispatch_items , :unit_of_measure_id, :integer
  end
end

class AddParentNodeIdToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :parent_node_id, :integer
  end
end

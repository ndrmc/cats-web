class StockMovement < ApplicationRecord
  belongs_to :project
  belongs_to :commodity

  belongs_to :hub, :class_name => 'Hub', :foreign_key => 'source_hub_id'
  belongs_to :hub, :class_name => 'Hub', :foreign_key => 'destination_hub_id'
 
  belongs_to :warehouse, :class_name => 'Warehouse', :foreign_key => 'source_warehouse_id'
  belongs_to :warehouse, :class_name => 'Warehouse', :foreign_key => 'destination_warehouse_id'

  belongs_to :store, :class_name => 'Store', :foreign_key => 'source_store_id'
  belongs_to :store, :class_name => 'Store', :foreign_key => 'destination_store_id'
  
  
end

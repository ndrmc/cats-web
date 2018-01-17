class StockMovement < ApplicationRecord
  belongs_to :project
  belongs_to :commodity
  belongs_to :unit_of_measure

  belongs_to :source_hub, :class_name => 'Hub', :foreign_key => 'source_hub_id'
  belongs_to :destination_hub, :class_name => 'Hub', :foreign_key => 'destination_hub_id'
 
  belongs_to :source_warehouse, :class_name => 'Warehouse', :foreign_key => 'source_warehouse_id'
  belongs_to :destination_warehouse, :class_name => 'Warehouse', :foreign_key => 'destination_warehouse_id'

  belongs_to :store, :class_name => 'Store', :foreign_key => 'source_store_id'
  belongs_to :store, :class_name => 'Store', :foreign_key => 'destination_store_id'
  
  enum status: [:open, :closed]
  
end

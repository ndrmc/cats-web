class WarehouseAllocation < ApplicationRecord
    enum status: [:started, :ready, :generated]
    belongs_to :operation
    belongs_to :region, :class_name => 'Location', :foreign_key => 'region_id'
end

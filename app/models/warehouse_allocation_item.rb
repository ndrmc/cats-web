class WarehouseAllocationItem < ApplicationRecord
    enum status: [:draft, :edited]
    belongs_to :warehouse_allocation
    belongs_to :warehouse
    belongs_to :fdp
    belongs_to :hub
    belongs_to :requisition
end

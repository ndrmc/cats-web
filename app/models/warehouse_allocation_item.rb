class WarehouseAllocationItem < ApplicationRecord
    enum status: [:draft, :edited]
    belongs_to :warehouse_allocation
    belongs_to :warehouse
end

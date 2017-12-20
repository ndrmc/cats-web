class WarehouseAllocationItem < ApplicationRecord
    enum status: [:draft, :edited]
    belongs_to :warehouse_allocation
end

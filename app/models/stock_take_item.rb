class StockTakeItem < ApplicationRecord
    has_one :adjustment
    belongs_to :stock_take
end

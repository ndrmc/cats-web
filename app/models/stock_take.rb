class StockTake < ApplicationRecord
    include Postable 
    has_many :stock_take_items
    has_many :adjustments , through: :stock_take_items

    after_save :pre_post
end


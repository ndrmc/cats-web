class Adjustment < ApplicationRecord
    include Postable

    belongs_to :stock_take_item
    belongs_to :stock_take

    enum adjustment_type:  {gain: 0, loss: 1}
    
end

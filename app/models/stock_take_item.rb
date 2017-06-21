class StockTakeItem < ApplicationRecord
    has_one :adjustment
    belongs_to :stock_take

    validates :donor_id, presence: {message: "is required!"}
    validates :project_id, presence: {messege: " is required!"}
    validates :commodity_id, presence: {messege: " is required!"}
    validates :commodity_category_id, presence: {messege: " is required!"}
    validates :actual_amount, presence: {messege: " is required!"}

end

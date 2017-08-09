class Bid < ApplicationRecord
    belongs_to :location, foreign_key: 'region_id'
end

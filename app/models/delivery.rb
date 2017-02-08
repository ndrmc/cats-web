class Delivery < ApplicationRecord
    include Filterable
    
    scope :gin_number, -> (gin_number) { where gin_number: gin_number }
    scope :fdp_id, -> (fdp_id) { where fdp_id: fdp_id }
    scope :operation_id, -> (operation_id) { where operation_id: operation_id }

    
end
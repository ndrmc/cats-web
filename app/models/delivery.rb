class Delivery < ApplicationRecord
    include Filterable
    
    scope :gin_number, -> (gin_number) { where gin_number: gin_number }
    scope :fdp_id, -> (fdp_id) { where fdp_id: fdp_id }
    scope :operation_id, -> (operation_id) { where operation_id: operation_id }

    has_many :delivery_details
    accepts_nested_attributes_for :delivery_details
end
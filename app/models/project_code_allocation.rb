class ProjectCodeAllocation < ApplicationRecord
    include Postable

    belongs_to :requisition
    belongs_to :fdp

    after_save :pre_post   
end

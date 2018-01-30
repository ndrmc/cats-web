class ProjectCodeAllocation < ApplicationRecord
    belongs_to :requisition
    belongs_to :fdp
end

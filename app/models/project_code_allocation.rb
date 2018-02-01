class ProjectCodeAllocation < ApplicationRecord
    include Postable

    belongs_to :requisition
    belongs_to :fdp
    belongs_to :hub
    belongs_to :warehouse
    belongs_to :store
    belongs_to :project
    belongs_to :unit_of_measure

    after_save :pre_post   
    after_destroy :reverse
end

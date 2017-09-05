# == Schema Information
#
# Table name: dispatch_items
#
#  id                    :integer          not null, primary key
#  dispatch_id           :integer
#  commodity_category_id :integer
#  commodity_id          :integer
#  quantity              :decimal(, )
#  project_id            :integer
#  created_by            :integer
#  modified_by           :integer
#  deleted               :boolean          default(FALSE)
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  guid_ref              :string
#  organization_id       :integer
#  unit_of_measure_id    :integer
#

class DispatchItem < ApplicationRecord
    belongs_to :dispatch

    belongs_to :commodity_category
    belongs_to :commodity
    belongs_to :receipt 
    belongs_to :project     
    belongs_to :organization
    belongs_to :unit_of_measure
end

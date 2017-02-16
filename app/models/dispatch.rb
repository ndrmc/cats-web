# == Schema Information
#
# Table name: dispatches
#
#  id                          :integer          not null, primary key
#  gin_no                      :string           not null
#  operation_id                :integer
#  requisition_number          :string
#  dispatch_date               :datetime
#  fdp_id                      :integer
#  weight_bridge_ticket_number :string
#  transporter_id              :integer
#  plate_number                :string
#  trailer_plate_number        :string
#  drivers_name                :string
#  remark                      :text
#  draft                       :boolean          default(FALSE)
#  created_by                  :integer
#  modified_by                 :integer
#  deleted                     :boolean          default(FALSE)
#  deleted_at                  :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  hub_id                      :integer
#  warehouse_id                :integer
#

class Dispatch < ApplicationRecord
    acts_as_paranoid 

    belongs_to :fdp 
    
    has_many :dispatch_items
end

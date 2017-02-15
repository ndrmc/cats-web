# == Schema Information
#
# Table name: delivery_details
#
#  id                :integer          not null, primary key
#  commodity_id      :integer
#  uom_id            :integer
#  sent_quantity     :decimal(, )
#  received_quantity :decimal(, )
#  delivery_id       :integer
#  created_by        :integer
#  modified_by       :integer
#  deleted           :boolean          default(FALSE)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class DeliveryDetail < ApplicationRecord
    belongs_to :delivery
    
end

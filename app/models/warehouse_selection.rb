# == Schema Information
#
# Table name: warehouse_selections
#
#  id                  :integer          not null, primary key
#  framework_tender_id :integer
#  location_id         :integer
#  warehouse_id        :integer
#  estimated_qty       :decimal(, )
#  created_by          :integer
#  modified_by         :integer
#  deleted             :boolean
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class WarehouseSelection < ApplicationRecord

     
  belongs_to :framework_tender, foreign_key: 'framework_tender_id'

  def woreda 
    Location.find location_id
  end

  def hub
      Warehouse.find warehouse_id
  end

  def framework_tender
    FrameworkTender.find framework_tender_id
  end

	belongs_to :location
	belongs_to :warehouse

end

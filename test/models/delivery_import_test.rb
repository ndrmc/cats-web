# == Schema Information
#
# Table name: delivery_imports
#
#  id                    :integer          not null, primary key
#  transporter_ref_no    :string
#  grn                   :string
#  requisition_no        :string
#  received_by           :string
#  received_date         :string
#  delivery_date         :string
#  quantity_received_qtl :string
#  prepared_date         :string
#  prepared_by           :string
#  gin                   :string
#  dispatch_date         :string
#  region                :string
#  origin_warehouse      :string
#  zone                  :string
#  woreda                :string
#  destination           :string
#  allocation_month      :string
#  allocation_year       :string
#  round                 :string
#  program               :string
#  commodity_type        :string
#  sub_commodity         :string
#  unit_type             :string
#  allocation_quantity   :string
#  dispatch_quantity     :string
#  donor                 :string
#  si_number             :string
#  transporter_name      :string
#  plate_no              :string
#  trailer_no            :string
#  driver_license        :string
#  hub_storekeeper       :string
#  project_code          :string
#  ltcd_no               :string
#  created_by            :integer
#  modified_by           :integer
#  deleted               :boolean          default(FALSE)
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  imported              :boolean
#

require 'test_helper'

class DeliveryImportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

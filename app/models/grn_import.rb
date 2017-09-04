# == Schema Information
#
# Table name: grn_imports
#
#  id                   :integer          not null, primary key
#  hub                  :string
#  warehouse            :string
#  storekeeper          :string
#  received_date        :string
#  donor                :string
#  supplier             :string
#  origin               :string
#  si_donor             :string
#  project_code         :string
#  grn                  :string
#  waybill_no           :string
#  commodity_class      :string
#  commodity_type       :string
#  total_units_received :string
#  unit_weight          :string
#  sent_mt              :string
#  received_in_bag      :string
#  received_in_mt       :string
#  vessel_name          :string
#  transporter_name     :string
#  plat_no              :string
#  trailer_no           :string
#  created_by           :integer
#  modified_by          :integer
#  deleted              :boolean          default(FALSE)
#  deleted_at           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  commodity_source     :string
#  imported             :boolean
#

class GrnImport < ApplicationRecord
end

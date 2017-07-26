# == Schema Information
#
# Table name: fdp_operations_logs
#
#  id                 :integer          not null, primary key
#  operation_id       :integer          not null
#  fdp_id             :integer          not null
#  location_id        :integer          not null
#  requisition_id     :integer          not null
#  commodity_id       :integer          not null
#  allocated_in_mt    :decimal(, )
#  dispatched_in_mt   :decimal(, )
#  delivered_in_mt	  :decimal(, )
#  distributed_in_mt  :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class FdpOperationsLog < ApplicationRecord
	has_one :operation
	has_one :fdp
	has_one :location
	has_one :requisition
	has_one :commodity
end

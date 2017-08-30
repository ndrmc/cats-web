# == Schema Information
#
# Table name: fdp_operations_logs
#
#  id                :integer          not null, primary key
#  operation_id      :integer
#  fdp_id            :integer
#  location_id       :integer
#  requisition_id    :integer
#  commodity_id      :integer
#  allocated_in_mt   :decimal(, )
#  dispatched_in_mt  :decimal(, )
#  delivered_in_mt   :decimal(, )
#  distributed_in_mt :decimal(, )
#  deleted           :boolean          default(FALSE)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class FdpOperationsLog < ApplicationRecord
end

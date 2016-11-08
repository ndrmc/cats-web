# == Schema Information
#
# Table name: requisitions
#
#  id             :integer          not null, primary key
#  requisition_no :string           not null
#  operation_id   :integer
#  commodity_id   :integer
#  region_id      :integer
#  zone_id        :integer
#  ration_id      :integer
#  requested_by   :string
#  requested_on   :date
#  status         :integer          default("draft"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class RequisitionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

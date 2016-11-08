# == Schema Information
#
# Table name: transport_requisitions
#
#  id           :integer          not null, primary key
#  region_id    :integer
#  operation_id :integer
#  created_date :date
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class TransportRequisitionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

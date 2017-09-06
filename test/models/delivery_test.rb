# == Schema Information
#
# Table name: deliveries
#
#  id                 :integer          not null, primary key
#  receiving_number   :string           not null
#  transporter_id     :integer          not null
#  fdp_id             :integer          not null
#  gin_number         :integer          not null
#  requisition_number :string           not null
#  received_by        :string           not null
#  received_date      :date             not null
#  status             :integer
#  operation_id       :integer
#  remark             :text
#  draft              :boolean
#  created_by         :integer
#  modified_by        :integer
#  deleted            :boolean          default(FALSE)
#  deleted_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  delivery_id_guid   :string
#  received_date_ec   :string
#

require 'test_helper'

class DeliveryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

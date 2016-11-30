# == Schema Information
#
# Table name: transporter_addresses
#
#  id             :integer          not null, primary key
#  transporter_id :integer
#  region_id      :integer
#  zone_id        :integer
#  woreda_id      :integer
#  subcity        :string
#  kebele         :string
#  house_no       :string
#  phone          :string
#  mobile         :string
#  email          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#

require 'test_helper'

class TransporterAddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

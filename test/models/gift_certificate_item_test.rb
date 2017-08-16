# == Schema Information
#
# Table name: gift_certificate_items
#
#  id                  :integer          not null, primary key
#  gift_certificate_id :integer
#  commodity_id        :integer
#  fund_source_id      :integer
#  unit_of_measure_id  :integer
#  currency_id         :integer
#  amount              :float            not null
#  estimated_value     :float
#  estimated_tax       :float
#  expiry_date         :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  created_by          :integer
#  modified_by         :integer
#  deleted_at          :datetime
#

require 'test_helper'

class GiftCertificateItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: quotations
#
#  id                :integer          not null, primary key
#  bid_submission_id :integer
#  store_id          :integer
#  destination_id    :integer
#  tariff_quote      :decimal(, )
#  remark            :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class QuotationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

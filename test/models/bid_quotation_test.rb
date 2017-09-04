# == Schema Information
#
# Table name: bid_quotations
#
#  id                 :integer          not null, primary key
#  bid_id             :integer
#  transporter_id     :integer
#  bid_quotation_date :date
#  created_by         :integer
#  modified_by        :integer
#  deleted_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class BidQuotationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

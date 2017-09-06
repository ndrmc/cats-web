# == Schema Information
#
# Table name: framework_tenders
#
#  id             :integer          not null, primary key
#  year           :integer
#  half_year      :integer
#  starting_month :integer
#  ending_month   :integer
#  status         :integer
#  remark         :text
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  certified_by   :integer
#

require 'test_helper'

class FrameworkTenderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

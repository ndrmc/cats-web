# == Schema Information
#
# Table name: operations
#
#  id                  :integer          not null, primary key
#  program_id          :integer
#  hrd_id              :integer
#  fscd_annual_plan_id :integer
#  name                :string           not null
#  descripiton         :text
#  year                :string
#  round               :integer
#  month               :integer
#  expected_start      :date
#  expected_end        :date
#  actual_start        :date
#  actual_end          :date
#  status              :integer          default("draft"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  created_by          :integer
#  modified_by         :integer
#  deleted_at          :datetime
#

require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

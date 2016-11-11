# == Schema Information
#
# Table name: fscd_annual_plans
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  code       :string
#  year       :string
#  duration   :integer
#  status     :integer          default("draft"), not null
#  archive    :boolean
#  ration_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FscdAnnualPlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: psnp_plans
#
#  id          :integer          not null, primary key
#  year_gc     :integer          not null
#  year_ec     :integer
#  status      :integer          default("draft"), not null
#  month_from  :integer
#  duration    :integer
#  ration_id   :integer
#  created_by  :integer
#  modified_by :integer
#  deleted     :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PsnpPlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

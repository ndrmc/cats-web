# == Schema Information
#
# Table name: hrds
#
#  id          :integer          not null, primary key
#  year_gc     :integer          not null
#  status      :integer          default("draft"), not null
#  month_from  :integer
#  duration    :integer
#  season_id   :integer
#  ration_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#  year_ec     :integer
#

require 'test_helper'

class HrdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

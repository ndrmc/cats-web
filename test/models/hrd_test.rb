# == Schema Information
#
# Table name: hrds
#
#  id         :integer          not null, primary key
#  year       :string           not null
#  status     :integer          default("draft"), not null
#  month_from :integer
#  month_to   :integer
#  duration   :integer
#  archived   :boolean
#  current    :boolean
#  season_id  :integer
#  ration_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class HrdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

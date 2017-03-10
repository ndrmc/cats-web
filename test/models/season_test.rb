# == Schema Information
#
# Table name: seasons
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#  month_from  :integer
#  month_to    :integer
#

require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

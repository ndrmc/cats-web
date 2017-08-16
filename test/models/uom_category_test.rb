# == Schema Information
#
# Table name: uom_categories
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

require 'test_helper'

class UomCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

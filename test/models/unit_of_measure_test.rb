# == Schema Information
#
# Table name: unit_of_measures
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :string
#  code            :string           not null
#  uom_type        :integer          default("ref"), not null
#  ratio           :decimal(8, 2)    not null
#  uom_category_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UnitOfMeasureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

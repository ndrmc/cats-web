# == Schema Information
#
# Table name: donors
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  code        :string           not null
#  responsible :boolean
#  source      :boolean
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

require 'test_helper'

class DonorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

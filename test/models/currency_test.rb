# == Schema Information
#
# Table name: currencies
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  symbol      :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

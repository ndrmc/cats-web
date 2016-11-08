# == Schema Information
#
# Table name: rations
#
#  id           :integer          not null, primary key
#  reference_no :string           not null
#  description  :string
#  current      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class RationTest < ActiveSupport::TestCase
  test "reference_no on ration should not be empty" do
    ration = Ration.new
    assert_not ration.save, "Saved ration without a title"
  end
end

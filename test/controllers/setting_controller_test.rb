require 'test_helper'

class SettingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get setting_index_url
    assert_response :success
  end

end

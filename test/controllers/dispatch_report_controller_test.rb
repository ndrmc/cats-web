require 'test_helper'

class DispatchReportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dispatch_report_index_url
    assert_response :success
  end

end

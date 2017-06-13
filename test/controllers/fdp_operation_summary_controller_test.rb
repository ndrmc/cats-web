require 'test_helper'

class FdpOperationSummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fdp_operation_summary_index_url
    assert_response :success
  end

end

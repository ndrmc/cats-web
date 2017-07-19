require 'test_helper'

class DispatchReportControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	setup do
		sign_in users(:admin)
		@operation = operations(:operation1)
		@requisition = requisitions(:requisition1)
		@requisition_item = requisition_items(:requisition_items1)
		@commodity = commodities(:commodity_1)
		@fdp = fdps(:fdp1)
		@location = locations(:location3)
		@dispatch = dispatches(:dispatch1)
	end

	test "should get index" do
		get "/dispatch_report/index", params: { operation: @operation.id }
		assert_response :success
	end
end

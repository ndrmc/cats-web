require 'test_helper'

class TransporterPaymentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:admin)
    @transporter_payment = transporter_payments(:one)
  end

  test "should get index" do
    get transporter_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_transporter_payment_url
    assert_response :success
  end

  test "should create transporter_payment" do
    assert_difference('TransporterPayment.count') do
      post transporter_payments_url, params: { transporter_payment: { approved_by: @transporter_payment.approved_by, approved_date: @transporter_payment.approved_date, bank_name: @transporter_payment.bank_name, cheque_no: @transporter_payment.cheque_no, datetime: @transporter_payment.datetime, paid_amount: @transporter_payment.paid_amount, payment_date: @transporter_payment.payment_date, payment_request_id: @transporter_payment.payment_request_id, prepared_by: @transporter_payment.prepared_by, status: @transporter_payment.status, voucher_no: @transporter_payment.voucher_no } }
    end

    assert_redirected_to transporter_payment_url(TransporterPayment.last)
  end

  test "should show transporter_payment" do
    get transporter_payment_url('en', @transporter_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_transporter_payment_url('en', @transporter_payment)
    assert_response :success
  end

  test "should update transporter_payment" do
    patch transporter_payment_url('en', @transporter_payment), params: { transporter_payment: { approved_by: @transporter_payment.approved_by, approved_date: @transporter_payment.approved_date, bank_name: @transporter_payment.bank_name, cheque_no: @transporter_payment.cheque_no, datetime: @transporter_payment.datetime, paid_amount: @transporter_payment.paid_amount, payment_date: @transporter_payment.payment_date, payment_request_id: @transporter_payment.payment_request_id, prepared_by: @transporter_payment.prepared_by, status: @transporter_payment.status, voucher_no: @transporter_payment.voucher_no } }
    assert_redirected_to transporter_payment_url('en', @transporter_payment)
  end

  test "should destroy transporter_payment" do
    assert_difference('TransporterPayment.count', -1) do
      delete transporter_payment_url('en', @transporter_payment)
    end

    assert_redirected_to transporter_payments_url
  end
end

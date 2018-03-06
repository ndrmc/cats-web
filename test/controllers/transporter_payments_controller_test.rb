require 'test_helper'

class TransporterPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
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
      post transporter_payments_url, params: { transporter_payment: { bankName: @transporter_payment.bankName, chequeNo: @transporter_payment.chequeNo, paidAmount: @transporter_payment.paidAmount, paymentDate: @transporter_payment.paymentDate, payment_requests_id: @transporter_payment.payment_requests_id, status: @transporter_payment.status, voucherNo: @transporter_payment.voucherNo } }
    end

    assert_redirected_to transporter_payment_url(TransporterPayment.last)
  end

  test "should show transporter_payment" do
    get transporter_payment_url(@transporter_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_transporter_payment_url(@transporter_payment)
    assert_response :success
  end

  test "should update transporter_payment" do
    patch transporter_payment_url(@transporter_payment), params: { transporter_payment: { bankName: @transporter_payment.bankName, chequeNo: @transporter_payment.chequeNo, paidAmount: @transporter_payment.paidAmount, paymentDate: @transporter_payment.paymentDate, payment_requests_id: @transporter_payment.payment_requests_id, status: @transporter_payment.status, voucherNo: @transporter_payment.voucherNo } }
    assert_redirected_to transporter_payment_url(@transporter_payment)
  end

  test "should destroy transporter_payment" do
    assert_difference('TransporterPayment.count', -1) do
      delete transporter_payment_url(@transporter_payment)
    end

    assert_redirected_to transporter_payments_url
  end
end

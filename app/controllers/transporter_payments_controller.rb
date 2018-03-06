class TransporterPaymentsController < ApplicationController
  before_action :set_transporter_payment, only: [:show, :edit, :update, :destroy]

  # GET /transporter_payments
  # GET /transporter_payments.json
  def index
    @transporter_payments = TransporterPayment.all
  end

  # GET /transporter_payments/1
  # GET /transporter_payments/1.json
  def show
  end

  # GET /transporter_payments/new
  def new
    @transporter_payment = TransporterPayment.new
  end

  # GET /transporter_payments/1/edit
  def edit
  end

  # POST /transporter_payments
  # POST /transporter_payments.json
  def create
    @transporter_payment = TransporterPayment.new(transporter_payment_params)

    respond_to do |format|
      if @transporter_payment.save
        format.html { redirect_to @transporter_payment, notice: 'Transporter payment was successfully created.' }
        format.json { render :show, status: :created, location: @transporter_payment }
      else
        format.html { render :new }
        format.json { render json: @transporter_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transporter_payments/1
  # PATCH/PUT /transporter_payments/1.json
  def update
    respond_to do |format|
      if @transporter_payment.update(transporter_payment_params)
        format.html { redirect_to @transporter_payment, notice: 'Transporter payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @transporter_payment }
      else
        format.html { render :edit }
        format.json { render json: @transporter_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transporter_payments/1
  # DELETE /transporter_payments/1.json
  def destroy
    @transporter_payment.destroy
    respond_to do |format|
      format.html { redirect_to transporter_payments_url, notice: 'Transporter payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transporter_payment
      @transporter_payment = TransporterPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transporter_payment_params
      params.require(:transporter_payment).permit(:payment_requests_id, :chequeNo, :voucherNo, :bankName, :paidAmount, :paymentDate, :status)
    end
end

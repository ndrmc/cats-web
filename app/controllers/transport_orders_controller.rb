class TransportOrdersController < ApplicationController
  before_action :set_transport_order, only: [:show, :edit, :update, :destroy]

  # GET /transport_orders
  # GET /transport_orders.json
  def index
    @transport_orders = TransportOrder.all
  end

  # GET /transport_orders/1
  # GET /transport_orders/1.json
  def show
  end

  # GET /transport_orders/new
  def new
    @transport_order = TransportOrder.new
  end

  # GET /transport_orders/1/edit
  def edit
  end

  # POST /transport_orders
  # POST /transport_orders.json
  def create
    @transport_order = TransportOrder.new(transport_order_params)

    respond_to do |format|
      if @transport_order.save
        format.html { redirect_to @transport_order, notice: 'Transport order was successfully created.' }
        format.json { render :show, status: :created, location: @transport_order }
      else
        format.html { render :new }
        format.json { render json: @transport_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transport_orders/1
  # PATCH/PUT /transport_orders/1.json
  def update
    respond_to do |format|
      if @transport_order.update(transport_order_params)
        format.html { redirect_to @transport_order, notice: 'Transport order was successfully updated.' }
        format.json { render :show, status: :ok, location: @transport_order }
      else
        format.html { render :edit }
        format.json { render json: @transport_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_orders/1
  # DELETE /transport_orders/1.json
  def destroy
    @transport_order.destroy
    respond_to do |format|
      format.html { redirect_to transport_orders_url, notice: 'Transport order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_order
      @transport_order = TransportOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transport_order_params
      params.fetch(:transport_order, {})
    end
end

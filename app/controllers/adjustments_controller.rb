class AdjustmentsController < ApplicationController
  include Administrated
  layout 'admin'
  before_action :set_adjustment, only: [:update]
  
  def edit
    @adjustment = Adjustment.find(params[:id])
  end

  # PATCH/PUT /adjustments/1
  # PATCH/PUT /adjustments/1.json
  def update
    @adjustment = Adjustment.find(params[:id])
    respond_to do |format|
      puts "----------------reason--#{@adjustment.reason}"
      @stock_take = StockTake.find(@adjustment.stock_take_id)
      if @adjustment.update(adjustment_params)
        format.html { redirect_to stock_take_path(@stock_take), notice: 'Adjustment was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_take }
      else
        format.html { redirect_to stock_take_path(@stock_take) }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adjustment
      @account = Adjustment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adjustment_params
      params.require(:adjustment).permit(:reason)
    end
end

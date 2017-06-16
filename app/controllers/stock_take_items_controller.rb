class StockTakeItemsController < ApplicationController
  before_action :set_stock_take_item, only: [:show, :edit, :update, :destroy]

  # GET /stock_take_items
  # GET /stock_take_items.json
  def index
    @stock_take_items = StockTakeItem.all
  end

  # GET /stock_take_items/1
  # GET /stock_take_items/1.json
  def show
  end

  # GET /stock_takes/new
  def new
     @stock_take = StockTake.find_by_id(params[:stock_take_id].to_i)
     @stock_take_item = StockTakeItem.new(stock_take_id: @stock_take.id)
  end

  # GET /stock_take_items/1/edit
  def edit
  end

   # POST /stock_take_items
  # POST /stock_take_items.json
  def create
     authorize StockTake
 
    @stock_take_item = StockTakeItem.new(stock_take_item_params)
    @stock_take = StockTake.find_by_id(@stock_take_item.stock_take_id)
    #to calculate theoretical amount take the positive sum of stock account by the specific commodity and donor
    @stock_take_item.theoretical_amount = (PostingItem
      .where ({account_id:Account.find_by({'code': :stock}).id,commodity_id: @stock_take_item.commodity_id, donor_id: @stock_take_item.donor_id, hub_id: @stock_take.hub_id}))
      .sum(&:quantity)
    
     
          
      
    
    respond_to do |format|
      if @stock_take_item.save
            #do adjustment if theoretical and actual amounts do not match
        
           
        if  @stock_take_item.theoretical_amount > @stock_take_item.actual_amount #loss
               @adjustment = Adjustment.new(stock_take_id:@stock_take_item.stock_take_id,
                                        stock_take_item_id: @stock_take_item.id,
                                        commodity_id: @stock_take_item.commodity_id,
                                        commodity_category_id:@stock_take_item.commodity_category_id,
                                        amount: @stock_take_item.theoretical_amount - @stock_take_item.actual_amount,
                                        adjustment_type: Adjustment.adjustment_types[:loss] )
             
              @adjustment.save!
        elsif @stock_take_item.theoretical_amount < @stock_take_item.actual_amount #gain
               @adjustment = Adjustment.new(stock_take_id:@stock_take_item.stock_take_id,
                                        stock_take_item_id: @stock_take_item.id,
                                        commodity_id: @stock_take_item.commodity_id,
                                        commodity_category_id:@stock_take_item.commodity_category_id,
                                        amount: @stock_take_item.actual_amount - @stock_take_item.theoretical_amount,
                                        adjustment_type: Adjustment.adjustment_types[:gain] )
             
            
              @adjustment.save!
        end  
        format.html { redirect_to stock_take_path(@stock_take), notice: 'Added item.' }
        format.json { render :show, status: :created, location: @stock_take }
      else
        format.html { render :new }
        format.json { render json: @stock_take_item.errors, status: :unprocessable_entity }
      end
    end
  end

 # PATCH/PUT /stock_take_items/1
  # PATCH/PUT /stock_take_items/1.json
  def update
    respond_to do |format|
      @stock_take = StockTake.find(@stock_take_item.stock_take_id)
      if @stock_take_item.update(stock_take_item_params)
       
        @adjustment = Adjustment.find_by_stock_take_item_id(@stock_take_item.id) 
        if @adjustment        
       
          if  @stock_take_item.theoretical_amount > @stock_take_item.actual_amount #stock_gain
            @adjustment.amount = @stock_take_item.theoretical_amount - @stock_take_item.actual_amount
            @adjustment.adjustment_type = Adjustment.adjustment_types[:gain]
          
          elsif @stock_take_item.theoretical_amount < @stock_take_item.actual_amount #loss
            @adjustment.amount = @stock_take_item.actual_amount - @stock_take_item.theoretical_amount
            @adjustment.adjustment_type = Adjustment.adjustment_types[:loss]
            
          end
          @adjustment.save!
        end
        format.html { redirect_to stock_take_path(@stock_take), notice: 'Stock take item was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_take }
      else
        format.html { render :edit }
        format.json { render json: @stock_take_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_takes/1
  # DELETE /stock_takes/1.json
  def destroy
    @stock_take = StockTake.find_by_id(@stock_take_item.stock_take_id)
    @stock_take_item.destroy
    respond_to do |format|
      format.html { redirect_to stock_take_path(@stock_take), notice: 'Stock take was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_take_item
      @stock_take_item = StockTakeItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_take_item_params
      params.require(:stock_take_item).permit(:donor_id,:project_id,:commodity_id, :commodity_category_id, :actual_amount, :stock_take_id)
    end
end

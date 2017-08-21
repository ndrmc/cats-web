class FrameworkTendersController < ApplicationController
  before_action :set_framework_tender, only: [:show, :edit, :update, :destroy]

  # GET /framework_tenders
  # GET /framework_tenders.json
  def index
    @framework_tenders = FrameworkTender.all
  end

  # GET /framework_tenders/1
  # GET /framework_tenders/1.json
  def show
    @framework_tender = FrameworkTender.find params[:id]
    $framework_tender_id = params[:id]
    $framework_tender_no =  @framework_tender.year.to_s + '/' +  @framework_tender.half_year.to_s
    @bids = Bid.where(framework_tender_id: params[:id])
    @ft_name = @framework_tender&.year.to_s + '/' + @framework_tender&.half_year.to_s
    @total_destinations = WarehouseSelection.where(:framework_tender_id => params[:id]).count
    @total_amount = WarehouseSelection.where(:framework_tender_id => params[:id]).sum(:estimated_qty)
    @user = User.find_by_id(@framework_tender&.certified_by)
  end

  # GET /framework_tenders/new
  def new
    @framework_tender = FrameworkTender.new
  end

  # GET /framework_tenders/1/edit
  def edit
  end

  # POST /framework_tenders
  # POST /framework_tenders.json
  def create
    @framework_tender = FrameworkTender.new(framework_tender_params)
    @framework_tender.status = :draft
    respond_to do |format|
      if @framework_tender.save
        format.html { redirect_to framework_tenders_path, notice: 'Framework tender was successfully created.' }
        format.json { render :show, status: :created, location: @framework_tender }
      else
        format.html { render :new }
        format.json { render json: @framework_tender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /framework_tenders/1
  # PATCH/PUT /framework_tenders/1.json
  def update
    respond_to do |format|
      if @framework_tender.update(framework_tender_params)
        format.html { redirect_to framework_tenders_path(:framework_tender_id => @framework_tender.id) , notice: 'Framework tender was successfully updated.' }
        format.json { render :show, status: :ok, location: @framework_tender }
      else
        format.html { render :edit }
        format.json { render json: @framework_tender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /framework_tenders/1
  # DELETE /framework_tenders/1.json
  def destroy
    @framework_tender.destroy
    respond_to do |format|
      format.html { redirect_to framework_tenders_url, notice: 'Framework tender was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_status
     @framework_tender = FrameworkTender.find params[:id]
     @framework_tender.status =  FrameworkTender.get_index(params[:status])
     @framework_tender.certified_by = current_user.id
      respond_to do |format|
          if @framework_tender.save
              format.html { redirect_to '/en/framework_tenders/' + @framework_tender.id.to_s, notice: 'Framework tender status was successfully updated.' }
          else
              format.html { 
                  flash[:error] = "Save failed! Please check your input and try again shortly."
                  redirect_to framework_tenders_url 
              }
          end
      end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_framework_tender
      @framework_tender = FrameworkTender.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def framework_tender_params
      params.require(:framework_tender).permit(:year, :half_year, :starting_month, :ending_month, :status, :remark)
    end
end

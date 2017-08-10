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
        format.html { redirect_to framework_tenders_path, notice: 'Framework tender was successfully updated.' }
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
     puts "-------------------"
     puts  FrameworkTender.get_index(params[:status])
     puts "-------------------"
     @framework_tender.status =  FrameworkTender.get_index(params[:status])
 
        respond_to do |format|
            if @framework_tender.save
                format.html { redirect_to framework_tenders_url, notice: 'Framework tender status was successfully updated.' }
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

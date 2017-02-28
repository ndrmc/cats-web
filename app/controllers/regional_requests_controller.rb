class RegionalRequestsController < ApplicationController
  before_action :set_regional_request, only: [:show, :edit, :update, :destroy]

  # GET /regional_requests
  # GET /regional_requests.json
  def index
    @regional_requests = RegionalRequest.all
  end

  # GET /regional_requests/1
  # GET /regional_requests/1.json
  def show
    @fdp_ids_with_a_request = @regional_request.regional_request_items.collect { |rri| rri.fdp_id }
  end

  # GET /regional_requests/new
  def new
    @regional_request = RegionalRequest.new
  end

  # GET /regional_requests/1/edit
  def edit
  end

  # POST /regional_requests
  # POST /regional_requests.json
  def create
    @regional_request = RegionalRequest.new(regional_request_params)

    respond_to do |format|
      if @regional_request.save

        @previous_regional_request = RegionalRequest.where("id < ? AND region_id = ?", @regional_request.id, @regional_request.region_id).order('id desc').limit(1)[0]

        fdp_locations = @regional_request.region.descendants.map { |d| d.id}.push @regional_request.region_id
        fdp_ids_in_region = Fdp.where( location_id: fdp_locations).map { |l| l.id}

        if @previous_regional_request
          @previous_regional_request.regional_request_items.each do |rri|
             RegionalRequestItem.new( regional_request_id: @regional_request.id, fdp_id: rri.fdp_id, number_of_beneficiaries: rri.number_of_beneficiaries).save

             fdp_ids_in_region -= [rri.fdp_id]
           end
        end

       fdp_ids_in_region.each do |fdp_id |
          RegionalRequestItem.new( regional_request_id: @regional_request.id, fdp_id: fdp_id, number_of_beneficiaries: 0).save
       end
        

        format.html { redirect_to @regional_request, notice: 'Regional request was successfully created.' }
        format.json { render :show, status: :created, location: @regional_request }
      else
        format.html { render :new }
        format.json { render json: @regional_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regional_requests/1
  # PATCH/PUT /regional_requests/1.json
  def update
    respond_to do |format|
      if @regional_request.update(regional_request_params)
        format.html { redirect_to @regional_request, notice: 'Regional request was successfully updated.' }
        format.json { render :show, status: :ok, location: @regional_request }
      else
        format.html { render :edit }
        format.json { render json: @regional_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regional_requests/1
  # DELETE /regional_requests/1.json
  def destroy
    @regional_request.destroy
    respond_to do |format|
      format.html { redirect_to regional_requests_url, notice: 'Regional request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_fdp_to_request 
    set_regional_request

    fdp = Fdp.find params[:fdp_id]

    number_of_beneficiaries = Float( params[:number_of_beneficiaries]) rescue nil 

    if !fdp || !number_of_beneficiaries then
      respond_to do |format|
        format.json { render json: {successful: false, errorMessage: "All required inputs are not supplied."} }
      end
      return       
    end

    respond_to do |format|
      rrdi = RegionalRequestItem.new( regional_request: @regional_request, fdp: fdp, number_of_beneficiaries: number_of_beneficiaries)
      
      if rrdi.save 
        format.json { render json: {successful: true, fdpName:  fdp.name, number_of_beneficiaries: number_of_beneficiaries, rrdi: rrdi } }
      else 
        format.json { render json: {successful: false, errorMessage: "Save failed. Please try again shortly."} }
      end
    end
  end
  
  def destroy_regional_request_item
    regional_request_item = RegionalRequestItem.find params[:id]

    regional_request_item.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def update_regional_request_item
    regional_request_item = RegionalRequestItem.find params[:id]
    regional_request_item.number_of_beneficiaries = params[:new_beneficiaries_value]
    regional_request_item.save

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def request_items 
    set_regional_request 

    @regional_request.regional_request_items 

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{@regional_request.region.name} region requests.xlsx\""
      }
    end
    
  end

  def upload_requests
    file = params[:file]

    case File.extname(file.original_filename)
      when '.xls' then spreadsheet = Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end

    set_regional_request

    (1..spreadsheet.last_row).each do |i|
      row =  spreadsheet.row(i)
      request_item = RegionalRequestItem.where(regional_request: @regional_request, fdp_id: row[0]).first

      if request_item
        request_item.number_of_beneficiaries = row[2]
        request_item.save
      else 
        Rails.logger.info("No RegionalRequestItem found for the fdp id: #{row[0]}. Skipping...")
      end
    end

    respond_to do |format|
        format.html { redirect_to @regional_request, notice: "Excel imported successfully." }
    end
    

  end 
  
  
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regional_request
      @regional_request = RegionalRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regional_request_params
      params.require(:regional_request).permit(:reference_number, :operation_id, :program_id, :region_id, :requested_date, :remark)
    end
end

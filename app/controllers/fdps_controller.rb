class FdpsController < ApplicationController
  before_action :set_fdp, only: [:show, :edit, :update, :destroy]

   include Administrated
   
  layout 'admin'

  # GET /fdps
  # GET /fdps.json
  def index
    @user = User.find(current_user.id)
    if @user.present? && @user.first_name != 'Administrator'
       fdp_locations = Location.find_by(id: @user.location_id).descendants.where( location_type: :woreda).map { |d| d.id}
      @fdps = Fdp.where( location_id: fdp_locations).all
    else
      @fdps = Fdp.all  
    end


     
  end

  # GET /fdps/1
  # GET /fdps/1.json
  def show
  end

  # GET /fdps/new
  def new
    @fdp = Fdp.new
  end

  # GET /fdps/1/edit
  def edit
  end

  # POST /fdps
  # POST /fdps.json
  def create
    @fdp = Fdp.new(fdp_params)
    @fdp.created_by = current_user.id
    respond_to do |format|
      if @fdp.save
        format.html { redirect_to fdps_path, notice: 'Fdp was successfully created.' }
        format.json { render :show, status: :created, location: @fdp }
      else
        format.html { render :new }
        format.json { render json: @fdp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fdps/1
  # PATCH/PUT /fdps/1.json
  def update
    @fdp.modified_by = current_user.id
    respond_to do |format|
      if @fdp.update(fdp_params)
        format.html { redirect_to @fdp, notice: 'Fdp was successfully updated.' }
        format.json { render :show, status: :ok, location: @fdp }
      else
        format.html { render :edit }
        format.json { render json: @fdp.errors, status: :unprocessable_entity }
      end
    end
  end

   def unarchive_fdp
    @fdp = Fdp.find(params[:id])
    @fdp.hide_fdp = false
      if (@fdp.save)
        respond_to do |format|
          format.html { redirect_to fdps_url, notice: 'Fdp was successfully unarchived.' }
          format.json { head :no_content }
        end
    end
  end

   def archive_fdp
    @fdp = Fdp.find(params[:id])
    @fdp.hide_fdp = true
      if (@fdp.save)
        respond_to do |format|
          format.html { redirect_to fdps_url, notice: 'Fdp was successfully archived.' }
          format.json { head :no_content }
        end
    end
  end


  # DELETE /fdps/1
  # DELETE /fdps/1.json
  def destroy
    @fdp.destroy
    respond_to do |format|
      format.html { redirect_to fdps_url, notice: 'Fdp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /fdps/location/1
  def get_by_location
    respond_to do |format|
      format.json { render json:  Fdp.where( :location_id => params[:location_id] )  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fdp
      @fdp = Fdp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fdp_params
      params.require(:fdp).permit(:name, :description, :lat, :lon, :active, :location_id, :region, :zone, :woreda)
    end
end

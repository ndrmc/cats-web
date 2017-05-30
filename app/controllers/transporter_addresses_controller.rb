class TransporterAddressesController < ApplicationController
  before_action :set_transporter_address, only: [:show, :edit, :update, :destroy]

  # GET /transporter_addresses
  # GET /transporter_addresses.json
  def index
    @transporter_addresses = TransporterAddress.all
  end

  # GET /transporter_addresses/1
  # GET /transporter_addresses/1.json
  def show
  end

  # GET /transporter_addresses/new
  def new
    @transporter = Transporter.find(params[:transporter_id])

    if @transporter.nil?
      format.html { render :new }
      format.json { render json: @transporter_address.errors, status: :unprocessable_entity }
    end
    @transporter_address = TransporterAddress.new
    @transporter_address.transporter_id = @transporter.id
  end

  # GET /transporter_addresses/1/edit
  def edit
  end

  # POST /transporter_addresses
  # POST /transporter_addresses.json
  def create

    @transporter_address = TransporterAddress.new(transporter_address_params)
    @transporter_address.created_by = current_user.id

    respond_to do |format|
      if @transporter_address.save
        format.html { redirect_to transporter_path(Transporter.find(@transporter_address.transporter_id)), notice: 'Transporter address was successfully created.' }
        format.json { render :show, status: :created, location: @transporter_address }
      else
        format.html { render :new }
        format.json { render json: @transporter_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transporter_addresses/1
  # PATCH/PUT /transporter_addresses/1.json
  def update
    @transporter_address.modified_by = current_user.id
    respond_to do |format|
      if @transporter_address.update(transporter_address_params)
        format.html { redirect_to @transporter_address, notice: 'Transporter address was successfully updated.' }
        format.json { render :show, status: :ok, location: @transporter_address }
      else
        format.html { render :edit }
        format.json { render json: @transporter_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transporter_addresses/1
  # DELETE /transporter_addresses/1.json
  def destroy
    @transporter_address.destroy
    respond_to do |format|
      format.html { redirect_to transporter_addresses_url, notice: 'Transporter address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transporter_address
      @transporter_address = TransporterAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transporter_address_params
      params.require(:transporter_address).permit(:region_id, :transporter_id, :city, :subcity, :kebele, :house_no, :phone, :mobile, :email)
    end
end

class FdpContactsController < ApplicationController
  before_action :set_fdp_contact, only: [:show, :edit, :update, :destroy]

include Administrated

 layout 'admin'
 
  # GET /fdp_contacts
  # GET /fdp_contacts.json
  def index
    @fdp_contacts = FdpContact.all
  end

  # GET /fdp_contacts/1
  # GET /fdp_contacts/1.json
  def show
  end

  # GET /fdp_contacts/new
  def new
    @fdp_contact = FdpContact.new
    if(params[:fdp_id])
      @fdp_contact.fdp_id = params[:fdp_id]
    end
  end

  # GET /fdp_contacts/1/edit
  def edit
  end

  # POST /fdp_contacts
  # POST /fdp_contacts.json
  def create
    @fdp_contact = FdpContact.new(fdp_contact_params)
     

    respond_to do |format|
      if @fdp_contact.save
        format.html { redirect_to fdp_path(Fdp.find(@fdp_contact.fdp_id)), notice: 'Fdp contact was successfully created.' }
        format.json { render :show, status: :created, location: @fdp_contact }
      else
        format.html { render :new }
        format.json { render json: @fdp_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fdp_contacts/1
  # PATCH/PUT /fdp_contacts/1.json
  def update
    respond_to do |format|
      if @fdp_contact.update(fdp_contact_params)
        format.html { redirect_to fdp_contacts_path, notice: 'Fdp contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @fdp_contact }
      else
        format.html { render :edit }
        format.json { render json: @fdp_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fdp_contacts/1
  # DELETE /fdp_contacts/1.json
  def destroy
    @fdp_contact.destroy
    respond_to do |format|
      format.html { redirect_to fdp_contacts_url, notice: 'Fdp contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fdp_contact
      @fdp_contact = FdpContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fdp_contact_params
      params.require(:fdp_contact).permit(:full_name, :mobile, :email, :fdp_id)
    end
end

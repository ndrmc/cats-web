class RoleTypesController < ApplicationController
  before_action :set_role_type, only: [:show, :edit, :update, :destroy]

  # GET /role_types
  # GET /role_types.json
  def index
    @role_types = RoleType.all
  end

  # GET /role_types/1
  # GET /role_types/1.json
  def show
  end

  # GET /role_types/new
  def new
    @role_type = RoleType.new
  end

  # GET /role_types/1/edit
  def edit
  end

  # POST /role_types
  # POST /role_types.json
  def create
    @role_type = RoleType.new(role_type_params)
    @role_type.created_by = current_user.id
    respond_to do |format|
      if @role_type.save
        format.html { redirect_to @role_type, notice: 'Role type was successfully created.' }
        format.json { render :show, status: :created, location: @role_type }
      else
        format.html { render :new }
        format.json { render json: @role_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role_types/1
  # PATCH/PUT /role_types/1.json
  def update
     @role_type.modified_by = current_user.id
    respond_to do |format|
      if @role_type.update(role_type_params)
        format.html { redirect_to @role_type, notice: 'Role type was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_type }
      else
        format.html { render :edit }
        format.json { render json: @role_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_types/1
  # DELETE /role_types/1.json
  def destroy
    @role_type.destroy
    respond_to do |format|
      format.html { redirect_to role_types_url, notice: 'Role type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_type
      @role_type = RoleType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_type_params
      params.require(:role_type).permit(:name, :description)
    end
end

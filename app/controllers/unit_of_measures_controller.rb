class UnitOfMeasuresController < ApplicationController
  before_action :set_unit_of_measure, only: [:show, :edit, :update, :destroy]
  include Administrated
  # GET /unit_of_measures
  # GET /unit_of_measures.json
  def index
    @unit_of_measures = UnitOfMeasure.all
  end

  # GET /unit_of_measures/1
  # GET /unit_of_measures/1.json
  def show
  end

  # GET /unit_of_measures/new
  def new
    @unit_of_measure = UnitOfMeasure.new
  end

  # GET /unit_of_measures/1/edit
  def edit
  end

  # POST /unit_of_measures
  # POST /unit_of_measures.json
  def create
    @unit_of_measure = UnitOfMeasure.new(unit_of_measure_params)
    @unit_of_measure.created_by = current_user.id

    respond_to do |format|
      if @unit_of_measure.save
        format.html { redirect_to unit_of_measures_path, notice: 'Unit of measure was successfully created.' }
        format.json { render :show, status: :created, location: @unit_of_measure }
      else
        format.html { render :new }
        format.json { render json: @unit_of_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_of_measures/1
  # PATCH/PUT /unit_of_measures/1.json
  def update
    @unit_of_measure.modified_by = current_user.id
    respond_to do |format|
      if @unit_of_measure.update(unit_of_measure_params)
        format.html { redirect_to unit_of_measures_path, notice: 'Unit of measure was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit_of_measure }
      else
        format.html { render :edit }
        format.json { render json: @unit_of_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_of_measures/1
  # DELETE /unit_of_measures/1.json
  def destroy
    @unit_of_measure.destroy
    respond_to do |format|
      format.html { redirect_to unit_of_measures_url, notice: 'Unit of measure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_unit_of_measure
    @unit_of_measure = UnitOfMeasure.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def unit_of_measure_params
    params.require(:unit_of_measure).permit(:name, :description, :code, :uom_type, :ratio, :uom_category_id)
  end
end

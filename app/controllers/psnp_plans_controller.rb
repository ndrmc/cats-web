class PsnpPlansController < ApplicationController
  before_action :set_psnp_plan, only: [:show, :edit, :update, :destroy]

  def index
    authorize PsnpPlan
    
    if params[:status]
      @psnp_plans = PsnpPlan.where status: params[:status]
    else
      @psnp_plans = PsnpPlan.all
    end
  end

  def show
    authorize PsnpPlan

    @psnp_plan = PsnpPlan.find params[:id]

    #@contributions = Contribution.where( psnp_plan_id: @psnp_plan.id)

    @beneficiaries_by_region = PsnpPlanItem.group('region_id' ).select( 'region_id, SUM(beneficiary) as total_beneficiaries')
  end

  def psnp_plan_items
    authorize PsnpPlan
    @psnp_plan = PsnpPlan.find params[:psnp_plan_id]
    psnp_plan_items = PsnpPlanItem.where psnp_plan_id: params[:psnp_plan_id], region_id: params[:region_id]

    @psnp_plan_items_by_zone = psnp_plan_items.group_by { |item| item.zone_id }

    @zones_with_no_psnp_plan_item = Location.find(params[:region_id]).children.pluck(:id) - @psnp_plan_items_by_zone.keys
  end

  def new_psnp_plan_item
    authorize PsnpPlan
    @psnp_plan = PsnpPlan.find params[:id]

    zone = Location.find params[:zone_id]

    taken_woredas_in_zone = PsnpPlanItem.where( zone_id: zone.id, psnp_plan_id: @psnp_plan.id).pluck(:woreda_id)

    all_woreda_ids_in_zone = zone.children.pluck(:id)

    @available_woredas = Location.find( all_woreda_ids_in_zone - taken_woredas_in_zone)

    render partial: 'add_woreda_form'
  end

  def save_psnp_plan_item
    authorize PsnpPlan
    @psnp_plan_item = PsnpPlanItem.new(params.permit(:psnp_plan_id, :woreda_id,  :beneficiary, :starting_month, :duration, :cash_ratio,:kind_ratio))

    if @psnp_plan_item.save
      render partial: 'psnp_plan_item_row'
    else
      render nothing: true, status: 400
    end
  end

  def remove_psnp_plan_id
    authorize PsnpPlan
    psnp_plan_item = PsnpPlanItem.find params[:id]

    psnp_plan_item.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end




  def edit_psnp_plan_form
    authorize PsnpPlan
    @psnp_plan_item = PsnpPlanItem.find(params[:id])
    render partial: 'edit_psnp_plan_form', layout: false
  end

  def update_psnp_plan_item
    authorize PsnpPlan
    @psnp_plan_item = PsnpPlanItem.find(params[:id])

    params.delete :id

    respond_to do |format|
      if @psnp_plan_item.update( params.permit(:starting_month, :duration, :beneficiary, :cash_ratio, :kind_ratio ))
        format.json { render json: { :successful => true }}
      else

        format.json { render json: { :successful => false, :messages => @psnp_plan_item.errors.full_messages }}
      end
    end
  end

  def download_psnp_plan_items
    authorize PsnpPlan
    @psnp_plan = PsnpPlan.find params[:id]
    @psnp_plan_items = PsnpPlanItem.where psnp_plan_id: params[:id]
  end


  def new
    authorize PsnpPlan
    @psnp_plan = PsnpPlan.new
  end

  def create
    authorize PsnpPlan
    @psnp_plan = PsnpPlan.new psnp_plan_params

    if @psnp_plan.save
      all_woredas = Location.where location_type: 'woreda'

      all_woredas.each do |woreda|
        PsnpPlanItem.new( woreda_id: woreda.id, psnp_plan: @psnp_plan, starting_month: @psnp_plan.month_from, beneficiary: 0, duration: @psnp_plan.duration ).save
      end

      # Add error handling in case when PsnpPlanItem save fails 

      respond_to do |format|
        format.html { redirect_to psnp_plans_url, notice: 'PSNP Plan was successfully created.' }
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = "Save failed! Please check your input and try again shortly."
          render :new
        }
      end
    end
  end

  def edit
    authorize PsnpPlan
    @psnp_plan = PsnpPlan.find params[:id]
  end

  def update

    authorize PsnpPlan
    @psnp_plan = PsnpPlan.find params[:id]
    @psnp_plan.modified_by = current_user.id
    respond_to do |format|
      if @psnp_plan.update(psnp_plan_params)
        format.html { redirect_to psnp_plans_url, notice: 'PSNP Plan was successfully updated.' }
      else
        format.html {
          flash[:error] = "Save failed! Please check your input and try again shortly."
          render :new
        }
      end
    end
  end

  def archive
    authorize PsnpPlan
    @psnp_plan = PsnpPlan.find params[:id]

    @psnp_plan.status = :archived

    respond_to do |format|
      if @psnp_plan.save
        format.html { redirect_to psnp_plans_url, notice: 'PSNP Plan was successfully archived.' }
      else
        format.html {
          flash[:error] = "Save failed! Please check your input and try again shortly."
          redirect_to psnp_plans_url
        }
      end
    end

  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_psnp_plan
      @psnp_plan = PsnpPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def psnp_plan_params
      params.require(:psnp_plan).permit( :id, :year_ec, :year_gc, :month_from, :season_id, :ration_id, :duration, :status )
    end
end

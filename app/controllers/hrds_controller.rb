class HrdsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_hrd
    def index 
        if params[:status]
            @hrds = Hrd.where status: params[:status]
        else
            @hrds = Hrd.all  
        end 
    end 

    def show
        @hrd = Hrd.find params[:id]
        @contributions = Contribution.where( hrd_id: @hrd.id)
        @beneficiaries_by_region = @hrd.hrd_items.group('region_id' ).select( 'region_id, SUM(beneficiary) as total_beneficiaries')
    end

    def hrd_items
        @hrd = Hrd.find params[:hrd_id]
        hrd_items = HrdItem.where hrd_id: params[:hrd_id], region_id: params[:region_id]
        @hrd_items_by_zone = hrd_items.group_by { |item| item.zone_id }
        @zones_with_no_hrd_item = Location.find(params[:region_id]).children.pluck(:id) - @hrd_items_by_zone.keys
    end 

    def new_hrd_item
        @hrd = Hrd.find params[:id]
        zone = Location.find params[:zone_id]
        taken_woredas_in_zone = HrdItem.where( zone_id: zone.id, hrd_id: @hrd.id).pluck(:woreda_id) 
        all_woreda_ids_in_zone = zone.children.pluck(:id)
        @available_woredas = Location.find( all_woreda_ids_in_zone - taken_woredas_in_zone)
        render partial: 'add_woreda_form'
    end 

    def save_hrd_item
        @hrd_item = HrdItem.new(params.permit(:hrd_id, :woreda_id,  :beneficiary, :starting_month, :duration))
        if @hrd_item.save 
            render partial: 'hrd_item_row'
        else 
            render nothing: true, status: 400 
        end
    end 

    def remove_hrd_id 
        @hrd_item = HrdItem.find params[:id]
        respond_to do |format|
            # Check if the deletion of the HRD item is successful and redirect to the referrer
            if @hrd_item.destroy
                format.html { redirect_to request.referrer, notice: 'HRD item was successfully deleted.' }
            else
                format.html { 
                    flash[:error] = "Delete failed! Please try again shortly."
                    redirect_to request.referrer 
                }
            end
        end
    end
    
    def edit_hrd_form 
        @hrd_item = HrdItem.find(params[:id])
        render partial: 'edit_hrd_form', layout: false 
    end 

    def update_hrd_item
         @hrd_item = HrdItem.find(params[:id])
         params.delete :id
         respond_to do |format|
            if @hrd_item.update( params.permit(:starting_month, :duration, :beneficiary ))
                format.json { render json: { :successful => true }}
            else 
                format.json { render json: { :successful => false }}
            end 
         end 
    end

    def download_hrd_items 
        @hrd = Hrd.find params[:id]
        @hrd_items = HrdItem.where hrd_id: params[:id]
    end 
    

    def new
        @hrd = Hrd.new 
    end

    def create
        @hrd = Hrd.new hrd_params  
        @hrd.created_by = current_user.id
        if @hrd.save
            all_woredas = Location.where location_type: 'woreda'

            all_woredas.each do |woreda| 
                HrdItem.new( woreda_id: woreda.id, hrd: @hrd, starting_month: @hrd.month_from, beneficiary: 0, duration: @hrd.duration ).save
            end 

            # Add error handling in case when HrdItem save fails 

            respond_to do |format|
                    format.html { redirect_to @hrd, notice: 'HRD was successfully created.' }
            end   
        else 
            respond_to do |format|
                    format.html { 
                        flash[:error] = "Save failed! Please check your input and try again shortly."
                        render :new }
            end   
        end 
    end

    def edit
        @hrd = Hrd.find params[:id]
    end

    def update 
        @hrd = Hrd.find params[:id]  
         @hrd.modified_by = current_user.id
        respond_to do |format|
            if @hrd.update(hrd_params)
                format.html { redirect_to hrds_url, notice: 'HRD was successfully updated.' }
            else
                format.html { 
                    flash[:error] = "Save failed! Please check your input and try again shortly."
                    render :new 
                }
            end
        end         
    end

    def archive
        @hrd = Hrd.find params[:id] 

        @hrd.status = :archived 

        respond_to do |format|
            if @hrd.save
                format.html { redirect_to hrds_url, notice: 'HRD was successfully archived.' }
            else
                format.html { 
                    flash[:error] = "Save failed! Please check your input and try again shortly."
                    redirect_to hrds_url 
                }
            end
        end

    end
    
    private 
def authorize_hrd
    authorize Hrd
end

    def hrd_params 
        params.require(:hrd).permit( :id, :year_ec, :year_gc, :month_from, :season_id, :ration_id, :duration )
    end
end

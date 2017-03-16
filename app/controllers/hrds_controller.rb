class HrdsController < ApplicationController

    def index 
        if params[:status]
            @hrds = Hrd.where status: params[:status]
        else
            @hrds = Hrd.all  
        end 
    end 

    def show
        @hrd = Hrd.find params[:id]

        @beneficiaries_by_region = HrdItem.group('region_id' ).select( 'region_id, SUM(beneficiary) as total_beneficiaries')
    end

    def hrd_items 
        @hrd = Hrd.find params[:hrd_id]
        @hrd_items = HrdItem.where hrd_id: params[:hrd_id], region_id: params[:region_id]
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

        if @hrd.save
            all_woredas = Location.where location_type: 'woreda'

            all_woredas.each do |woreda| 
                HrdItem.new( woreda_id: woreda.id, hrd: @hrd, starting_month: @hrd.month_from, beneficiary: 0, duration: @hrd.duration ).save
            end 

            # Add error handling in case when HrdItem save fails 

            respond_to do |format|
                    format.html { redirect_to hrds_url, notice: 'HRD was successfully created.' }
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
        @hrd = Hrd.find params[:id]
    end

    def update 
        @hrd = Hrd.find params[:id]  

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
        def hrd_params 
            params.require(:hrd).permit( :id, :year_ec, :year_gc, :month_from, :season_id, :ration_id, :duration )
        end
end

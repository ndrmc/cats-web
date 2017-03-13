class HrdsController < ApplicationController

    def index 
        @hrds = Hrd.all 
    end 


    def new 
        @hrd = Hrd.new 
    end

    def create
        @hrd = Hrd.new hrd_params  

        respond_to do |format|
            if @hrd.save
                format.html { redirect_to hrds_url, notice: 'HRD was successfully created.' }
            else
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

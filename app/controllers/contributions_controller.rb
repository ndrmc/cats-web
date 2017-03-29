class ContributionsController < ApplicationController

    def new
        taken_donors = Contribution.where(hrd_id: params[:hrd_id]).pluck(:donor_id)

        @available_donors = Donor.where.not( id: taken_donors)

        @contribution = Contribution.new

        render partial: 'form', layout: false 
    end 

    def edit 
        @contribution = Contribution.find params[:id]

        taken_donors = Contribution.where(hrd_id: params[:hrd_id]).pluck(:donor_id)

        @available_donors = Donor.where.not( id: taken_donors) + [@contribution.donor]

        render partial: 'form', layout: false
    end 
    

    def create 
        @contribution = nil 

        if params[:id] #update 
            @contribution = Contribution.find params[:id]

            @contribution.update( contribution_params )
        else 
            @contribution = Contribution.new( contribution_params)
            @contribution = @contribution.save ? @contribution : nil
        end 


        respond_to do |format | 
            if @contribution 
                format.html { render partial: 'contrib_row', locals: { contribution: @contribution} ,layout: false }
            else
                format.html { render nothing: true, status: 401 } 
            end
        end 
    end 

    def destroy
        Contribution.find(params[:id]).destroy!

        respond_to do |format|
            format.json { render json:  [ deleted: true ].to_json  }
        end

    end

    private 
        def contribution_params 
            params.permit( :id, :donor_id, :contribution_type, :hrd_id, :pledged_date, :amount )
        end 
end

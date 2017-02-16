class RequisitionsController < ApplicationController

    def get_requisiton_by_number

        requisition = Requisition.find_by_requisition_no params[:requisition_no]

        respond_to do |format|
            if requisition
                format.json { render json: { requisition: requisition }}
            else 
                format.json { render json: { }, status: 404}
            end
        end

        
    end

end

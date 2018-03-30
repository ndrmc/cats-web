class Api::AdjustmentsController < Api::ApiController
      
    def index
      render json: Adjustment.all
    end
  
    def show
      @adjustment = Adjustment.find(params[:id])   
      json_response(@adjustment, :ok)         
    end
      
  end
  
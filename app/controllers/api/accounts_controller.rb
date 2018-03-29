class Api::AccountsController < Api::ApiController
    before_action :set_account, only: [:update, :destroy]
  
    def index
      render json: Account.all
    end
  
    def create
      @account = Account.create!(account_params)
      json_response(@account, :created)
    end
  
    def update
      @account.update(account_params)
      head :no_content
    end
  
    def show
      @account = Account.find(params[:id])   
      json_response(@account, :ok)         
    end
  
    def destroy
      @account.destroy
      head :no_content
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end
  
    def account_params
        params.require(:account).permit(:name, :code, :description)
    end
  
  end
  
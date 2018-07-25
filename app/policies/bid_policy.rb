class BidPolicy < ApplicationPolicy
    
    
 def index?
    @current_user.permission('Bid', :guest)
 end

 # GET /bids/1
 # GET /bids/1.json
 def show?
    @current_user.permission('Bid', :guest)
 end

 # GET /bids/new
 def new?
    @current_user.permission('Bid', :clerk)
 end

 # GET /bids/1/edit
 def edit?
    @current_user.permission('Bid', :clerk)
 end

 # POST /bids
 # POST /bids.json
 def create?
    @current_user.permission('Bid', :clerk)
 end

 # PATCH/PUT /bids/1
 # PATCH/PUT /bids/1.json
 def update?
    @current_user.permission('Bid', :clerk)
 end

 # DELETE /bids/1
 # DELETE /bids/1.json
 def destroy?
    @current_user.permission('Bid', :clerk)
 end

 def update_status?
    @current_user.permission('Bid', :clerk)
 end

 def request_for_quotations?
    @current_user.permission('Bid', :clerk)
 end

def download_rfq?
    @current_user.permission('Bid', :clerk)
end

 def upload_rfq?
    @current_user.permission('Bid', :clerk)
 end

 def generate_winners?
    @current_user.permission('Bid', :clerk)
 end

 def regenerate_bid?
    @current_user.permission('Bid', :clerk)
 end

 def transporter_quotes?
    @current_user.permission('Bid', :clerk)
 end

 def remove_bid_quotation?
    @current_user.permission('Bid', :clerk)
 end

 def view_bid_winners?
    @current_user.permission('Bid', :clerk)
 end

 def contracts?
    @current_user.permission('Bid', :clerk)
 end

 def download_contract?
    @current_user.permission('Bid', :clerk)
 end

 def sign_contract?
    @current_user.permission('Bid', :clerk)
 end


end


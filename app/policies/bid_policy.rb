class BidPolicy < ApplicationPolicy
    
    
 def index?
    permission = Permission.where(name: 'Bid', user_type: :guest).first
    @current_user.has_permission(permission.id) 
 end

 # GET /bids/1
 # GET /bids/1.json
 def show?
    permission = Permission.where(name: 'Bid', user_type: :guest).first
    @current_user.has_permission(permission.id)
 end

 # GET /bids/new
 def new?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # GET /bids/1/edit
 def edit?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # POST /bids
 # POST /bids.json
 def create?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # PATCH/PUT /bids/1
 # PATCH/PUT /bids/1.json
 def update?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # DELETE /bids/1
 # DELETE /bids/1.json
 def destroy?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def update_status?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def request_for_quotations?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def upload_rfq?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def generate_winners?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def regenerate_bid?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def transporter_quotes?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def remove_bid_quotation?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def view_bid_winners?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def contracts?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def download_contract?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def sign_contract?
    permission = Permission.where(name: 'Bid', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end


end


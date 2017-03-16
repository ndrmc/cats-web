Rails.application.routes.draw do
  resources :case_teams
  resources :role_types
  resources :transporters
  resources :transporter_addresses  
  get 'setting/index'
  devise_for :users

  get "home/index"
  get "home/minor"
  get "home/other"

  #get 'locations(/:parent_id)', to: 'locations#index', as: :locations
  #post 'locations', to: 'locations#create', as: :locations

  resources :locations

  get 'locations/:parentId/children', to: 'locations#children'


  resources :users
  resources :roles

  get 'users/:id/roles', to: 'users#roles'

  put 'users/:id/updateRoles', to: 'users#updateRoles'

  resources :currencies
  resources :donors
  resources :programs

  resources :commodity_sources
  resources :commodity_categories
  resources :commodities
  resources :unit_of_measures
  resources :hubs, shallow: true do
    resources :warehouses, shallow: true do
      resources :stores
    end
  end

  resources :warehouses
  resources :stores
  resources :operations
  resources :accounts
  resources :fdps
  resources :fdp_contacts
  get 'fdps/location/:location_id', to: 'fdps#get_by_location'

  resources :organizations
  resources :projects
  resources :deliveries

  resources :rations
  resources :ration_items


  get 'ration_items/unitOfMeasureSelectForCommodity'

  resources :receipts
  resources :dispatches

  resources :requisitions
  resources :gift_certificates
  
  get '/requisitions/get_requisiton_by_number'
  get '/requisitions/prepare/:request_id', to: 'requisitions#prepare'
  post '/requisitions/prepare/:request_id', to: 'requisitions#generate'
  get '/requisitions/summary/:region_id/:operation_id', to: 'requisitions#summary'
  get '/requisitions/add_requisition/:request_id/:zone_id/:commodity_id', to: 'requisitions#add_requisition'

  resources :regional_requests
  post '/regional_requests/add_fdp_to_request'
  post '/regional_requests/update_regional_request_item'
  delete '/regional_requests/destroy_regional_request_item/:id', to: 'regional_requests#destroy_regional_request_item'
  get '/regional_requests/request_items/:id', to: 'regional_requests#request_items'
  post '/regional_requests/upload_requests/:id', to: 'regional_requests#upload_requests'


  root to: 'dashboard#index'

end

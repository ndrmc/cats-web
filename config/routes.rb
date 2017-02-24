Rails.application.routes.draw do
  resources :transporters
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

  resources :rations do
    resources :ration_items
  end

  get 'ration_items/unitOfMeasureSelectForCommodity'

  resources :receipts
  resources :dispatches

  get 'requisitions/get_requisiton_by_number'

  resources :regional_requests 
  post '/regional_requests/add_fdp_to_request'

  root to: 'dashboard#index'

end

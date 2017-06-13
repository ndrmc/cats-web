Rails.application.routes.draw do
  
  
 
  get 'fdp_operation_summary/index'

 scope "(:locale)", locale: /en|am/ do
  resources :case_teams
   resources :permissions
  resources :departments
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

  put 'users/:id/updateDepartments', to: 'users#updateDepartments'

  get 'users/:id/user_departments', to: 'users#user_departments'

  put 'users/:id/updatePermissions', to: 'users#updatePermissions'

  get 'users/:id/user_permissions', to: 'users#user_permissions'

  put 'users/:id/updateDepartmentPermission', to: 'users#updateDepartmentPermission'

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
  resources :journals
  resources :fdps
  resources :fdp_contacts
  get 'fdps/location/:location_id', to: 'fdps#get_by_location'

  resources :organizations
  resources :projects
  post '/projects/:id/archive', to: 'projects#archive'
  resources :deliveries

  resources :rations
  resources :ration_items

  get 'ration_items/unitOfMeasureSelectForCommodity'

  resources :receipts
  resources :dispatches

  get '/requisitions/get_requisiton_by_number'
  get '/requisitions/prepare/:request_id', to: 'requisitions#prepare'
  post '/requisitions/prepare/:request_id', to: 'requisitions#generate'
  get '/requisitions/summary', to: 'requisitions#summary'
  get '/requisitions/add_requisition', to: 'requisitions#add_requisition'

  resources :requisitions
  resources :gift_certificates
  

  resources :regional_requests
  post '/regional_requests/add_fdp_to_request'
  post '/regional_requests/update_regional_request_item'
  delete '/regional_requests/destroy_regional_request_item/:id', to: 'regional_requests#destroy_regional_request_item'
  get '/regional_requests/request_items/:id', to: 'regional_requests#request_items'
  post '/regional_requests/upload_requests/:id', to: 'regional_requests#upload_requests'

  get '/hrds/hrd_items', to: 'hrds#hrd_items'
  get '/hrds/download_hrd_items/:id', to: 'hrds#download_hrd_items'
  get '/hrds/archive/:id', to: 'hrds#archive'
  get '/hrds/edit_hrd_form/:id', to: 'hrds#edit_hrd_form'
  get '/hrds/new_hrd_item/:id', to: 'hrds#new_hrd_item'
  get '/hrds/update_hrd_item', to: 'hrds#update_hrd_item'
  post '/hrds/save_hrd_item', to: 'hrds#save_hrd_item'
  delete '/hrds/remove_hrd_id/:id', to: 'hrds#remove_hrd_id'
  resources :hrds


  resources :contributions

  get '/psnp_plans/psnp_plan_items', to: 'psnp_plans#psnp_plan_items'
  get '/psnp_plans/archive/:id', to: 'psnp_plans#archive'
  get '/psnp_plans/edit_psnp_plan_form/:id', to: 'psnp_plans#edit_psnp_plan_form'
  get '/psnp_plans/new_psnp_plan_item/:id', to: 'psnp_plans#new_psnp_plan_item'
  get '/psnp_plans/update_psnp_plan_item', to: 'psnp_plans#update_psnp_plan_item'
  post '/psnp_plans/save_psnp_plan_item', to: 'psnp_plans#save_psnp_plan_item'
  delete '/psnp_plans/remove_psnp_plan_id/:id', to: 'psnp_plans#remove_psnp_plan_id'
  resources :psnp_plans

  
  root to: 'dashboard#index'
  # GraphQL configuration
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/queries"
  resources :queries
end
end

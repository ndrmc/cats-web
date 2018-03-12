Rails.application.routes.draw do

 

 
  get '/warehouse_allocations/warehouse_allocation_zonal_view'
  get '/warehouse_allocations/warehouse_allocation_fdp_view'
  resources :warehouse_allocations
  post 'warehouse_allocations/generate', to: 'warehouse_allocations#generate'
  post 'warehouse_allocations/reset_allocation', to: 'warehouse_allocations#reset_allocation'
  post 'warehouse_allocations/close_allocation', to: 'warehouse_allocations#close_allocation'
  post '/en/warehouse_allocations/change_wai', to: 'warehouse_allocations#change_wai'

  post '/en/warehouse_allocations/change_wa_woreda', to: 'warehouse_allocations#change_wa_woreda'

  get 'stock_status/index'

  get 'fdp_operation_summary/index'


 scope "(:locale)", locale: /en|am/ do

  get 'transporter_payments/update_status', to: 'transporter_payments#update_status'
  resources :transporter_payments
  resources :project_code_allocations
  post '/project_code_allocations/create_for_requisition', to: 'project_code_allocations#create_for_requisition'
  delete '/project_code_allocations/destroy_project_code_allocations/:id', to: 'project_code_allocations#destroy_project_code_allocations'
  get '/stock_movements/validate_quantity', to: 'stock_movements#validate_quantity'
  post '/stock_movements/createReceive/:id', to: 'stock_movements#createReceive'
  get '/stock_movements/getCommodity/:id', to: 'stock_movements#getCommodity'
  post '/stock_movements/close/:id', to: 'stock_movements#close'
  post '/stock_movements/check_stock', to: 'stock_movements#check_stock' 
  get '/stock_movements/get_dispatch', to: 'stock_movements#get_dispatch'   
  post '/stock_movements/stock_movement_dispatch', to: 'stock_movements#stock_movement_dispatch' 
  post '/stock_movements/stock_movement_dispatch_edit', to: 'stock_movements#stock_movement_dispatch_edit'
  delete 'stock_movements/delete_dispatch/:id', to: 'stock_movements#delete_dispatch'
  delete 'stock_movements/stock_movement_destroy_receive/:id', to: 'stock_movements#stock_movement_destroy_receive'
  resources :stock_movements

  get '/transport_requisitions/print', to: 'transport_requisitions#print'
  get '/transport_requisitions/get_fdps_list', to: 'transport_requisitions#get_fdps_list'
  post '/transport_requisitions/create_to_for_exceptions', to: 'transport_requisitions#create_to_for_exceptions'
  resources :transport_requisitions
  
   resources :bids
   get '/bids/request_for_quotations/:id', to: 'bids#request_for_quotations'
   post 'bids/upload_rfq', to: 'bids#upload_rfq'
   get 'bids/update_status/:id/:status', to: 'bids#update_status'
   get '/bids/transporter_quotes/:id', to: 'bids#transporter_quotes'
   delete '/bids/remove_bid_quotation/:id', to: 'bids#remove_bid_quotation'
   post '/bids/:id/generate_winners', to: 'bids#generate_winners'
   get 'bids/view_bid_winners/:id', to: 'bids#view_bid_winners'
   get 'bids/contracts/:id', to: 'bids#contracts'
   get 'bids/download_contract/:id', to: 'bids#download_contract', format: 'docx' 
   get 'bids/sign_contract/:id', to: 'bids#sign_contract'
   
   resources :framework_tenders
   get 'framework_tenders/update_status/:id/:status', to: 'framework_tenders#update_status'   
   get 'framework_tenders/bids/transporter_quotes/:id', to: 'bids#transporter_quotes'

   resources :case_teams

   resources :permissions
  resources :departments
  resources :role_types
  get 'transporters/update_status', do: 'transporters#update_status'
  get 'transporters/transporter_fdp_detail', to: 'transporters#transporter_fdp_detail'
  get 'transporters/transporter_verify_detail', to: 'transporters#transporter_verify_detail'
  post '/transporters/processPayment/:id', to: 'transporters#processPayment'
  get '/transporters/payment_request', to: 'transporters#payment_request'
  get '/transporters/payment__request_items/:id', to: 'transporters#payment__request_items'
  get '/transporters/dispatches_list_per_fdp', to: 'transporters#dispatches_list_per_fdp'
  get '/transporters/print_payment_request', to: 'transporters#print_payment_request'
  get '/transporters/reject_payment_request', to: 'transporters#reject_payment_request'
  get '/transporters/update_status_all', to: 'transporters#update_status_all'
  resources :transporters
  resources :transport_orders
  get '/transport_orders/print/:id', to: 'transport_orders#print'
  resources :transporter_addresses  
  get 'setting/index'
  devise_for :users

  get "home/index"
  get "home/minor"
  get "home/other"

  get 'warehouse_selections/get_by_region'
  resources :warehouse_selections
  

  #get 'locations(/:parent_id)', to: 'locations#index', as: :locations
  #post 'locations', to: 'locations#create', as: :locations

  resources :locations

  get 'locations/:parentId/children', to: 'locations#children'


  resources :users
  resources :roles

  get 'users/:id/user_preference', to: 'users#user_preference'

  put 'users/:id/updateUserPreference', to: 'users#updateUserPreference'

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

  get 'commodities/get_by_category/:commodity_category_id', to: 'commodities#get_by_category'

  resources :organizations
  resources :projects
  post '/projects/:id/archive', to: 'projects#archive'
  post '/projects/:id/unarchive', to: 'projects#unarchive'
  get '/projects/get_commodities/:id', to: 'projects#get_commodities'
  get '/projects/get_commodity_source_code/:id', to: 'projects#get_commodity_source_code'
  
  resources :deliveries

  resources :rations
  resources :ration_items

  get 'ration_items/unitOfMeasureSelectForCommodity'

  get '/receipts/receipt_report', to: 'receipts#receipt_report'
  post '/receipts/receipt_report_generate', to: 'receipts#receipt_report_generate'
  post '/receipts/check_stock', to: 'receipts#check_stock'
  get '/stock_movements/stock_movement_edit/:id', to: 'stock_movements#stock_movement_edit'
  resources :receipts
  
  get '/receipts/return_receipt_detail/:id', to: 'receipts#return_receipt_detail'

  get '/receipts/getProjectCodeStatus/:id', to: 'receipts#getProjectCodeStatus'
  get '/receipts/new/:id', to: 'receipts#new'

  get '/dispatches/dispatch_report', to: 'dispatches#dispatch_report'
  post '/dispatches/dispatch_report_generate', to: 'dispatches#dispatch_report_generate'
  post '/dispatches/check_stock', to: 'dispatches#check_stock' 
  post '/dispatches/validate_quantity', to: 'dispatches#validate_quantity'
  get '/dispatches/basic', to: 'dispatches#basic'
  resources :dispatches
 

  get '/requisitions/get_requisiton_by_number'
  get '/requisitions/prepare/:request_id', to: 'requisitions#prepare'
  post '/requisitions/prepare/:request_id', to: 'requisitions#generate'
  get '/requisitions/summary/:request_id', to: 'requisitions#summary'
  get '/requisitions/add_requisition', to: 'requisitions#add_requisition'
  get '/requisitions/print', to: 'requisitions#print'
  get '/requisitions/print_rrd', to: 'requisitions#print_rrd'
  delete '/requisitions/delete_regional_requests_fdps_with_zero_ben_no/:id', to: 'requisitions#delete_regional_requests_fdps_with_zero_ben_no'

  resources :requisitions
  get '/gift_certificates/gift_certificate_report', to: 'gift_certificates#gift_certificate_report'
  post '/gift_certificates/gift_certificate_generate', to: 'gift_certificates#gift_certificate_generate'
  resources :gift_certificates
  

  resources :regional_requests
  get '/regional_requests/print/:id', to: 'regional_requests#print'
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

  get 'stock_takes/:id/post', to: 'stock_takes#post_stock_take'
  resources :stock_takes
  resources :stock_take_items
  resources :adjustments
  resources :payment_requests
  resources :payment_request_items
  

  get'/stock_reports', to: 'stock_reports#index'
  get '/stock_reports/stock_status_by_project_code', to: 'stock_reports#stock_status_by_project_code'
  get '/stock_reports/stock_status_by_commodity_type', to: 'stock_reports#stock_status_by_commodity_type'
  get '/stock_reports/received_stock_by_project_code', to: 'stock_reports#received_stock_by_project_code'
  get '/stock_reports/received_stock_by_commodity_source', to: 'stock_reports#received_stock_by_commodity_source' 

  get '/stock_reports/dispatch_report_by_project', to: 'stock_reports#dispatch_report_by_project'

  get '/stock_reports/stock_summary_by_project_code', to: 'stock_reports#stock_summary_by_project_code' 
  
  root to: 'dashboard#index'
  # GraphQL configuration
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/queries"
  resources :queries
end
end

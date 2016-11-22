Rails.application.routes.draw do
  get 'setting/index'
  devise_for :users

  get "home/index"
  get "home/minor"
  get "home/other"

  #get 'locations(/:parent_id)', to: 'locations#index', as: :locations
  #post 'locations', to: 'locations#create', as: :locations

  resources :locations

  get 'locations/:parentId/children', to: 'locations#children'


  resources :currencies
  resources :donors
  resources :programs
  resources :commodity_categories
  resources :commodities
  resources :unit_of_measures
  resources :operations
  resources :accounts
  resources :fdps

  root to: 'dashboard#index'

end

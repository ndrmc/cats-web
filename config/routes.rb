Rails.application.routes.draw do
  get 'setting/index'

  devise_for :users

  get "home/index"
  get "home/minor"
  get "home/other"

  #get 'locations(/:parent_id)', to: 'locations#index', as: :locations
  #post 'locations', to: 'locations#create', as: :locations

  resources :locations


  resources :currencies
  resources :donors
  resources :programs

  root to: 'dashboard#index'

end

Rails.application.routes.draw do
  get 'setting/index'
  devise_for :users

  get "home/index"
  get "home/minor"
  get "home/other"

  resources :currencies
  resources :donors
  resources :location_types
  resources :programs
  resources :commodity_categories
  resources :commodities
  resources :unit_of_measures
  resources :operations
  resources :accounts

  root to: 'dashboard#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

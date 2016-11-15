Rails.application.routes.draw do
  get 'setting/index'

  devise_for :users

  get "home/index"
  get "home/minor"
  get "home/other"

  resources :currencies
  resources :donors
  resources :programs

  root to: 'dashboard#index'

end

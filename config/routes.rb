Rails.application.routes.draw do
  get 'setting/index'
  namespace :setting do
  resources :commodity_types, path: '/commodity_types'
  end
  devise_for :users
  get "home/index"
  get "home/minor"
  get "home/other"

  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

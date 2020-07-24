Rails.application.routes.draw do
  root 'admin#index'

  resources :users, only: :show
  resources :orders, only: [:index, :show], param: :number

  resources :reports, only: :index do
    get :coupons, on: :collection
    get :sales, on: :collection
  end
end

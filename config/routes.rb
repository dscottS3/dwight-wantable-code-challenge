Rails.application.routes.draw do
  root 'admin#index'

  resources :users, only: :show
  resources :orders, only: [:index, :show], param: :number do
    patch :cancel, on: :member
  end

  resources :reports, only: :index do
    get :coupons, on: :collection
    get :sales, on: :collection
  end
end

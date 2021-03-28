Rails.application.routes.draw do

  post :user_token, to: 'user_token#create'
  resource :user do
    post :update_basket, on: :member
  end

  resources :orders do
    put :confirm, on: :collection
  end

  post :superuser_token, to: 'superuser_token#create'
  resource :superuser do
    get :show_user, on: :member
  end

  resources :dishes
end

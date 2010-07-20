Kln::Application.routes.draw do |map|
  resources :orders, :only => [:index]
  match 'orders/change', :to => 'orders#change', :via => 'post'

  resources :comments

  resources :posts do
    member do
      get :delete
    end
    resources :comments
  end

  devise_for :users

  root :to => "orders#index"
end


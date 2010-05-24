Kln::Application.routes.draw do |map|
  resources :comments

  resources :posts do
    member do
      get :delete
    end
    resources :comments
  end

  devise_for :users

  root :to => "welcome#index"
end


Kln::Application.routes.draw do |map|
  resources :orders, :only => [:index]
  match 'orders/change', :to => 'orders#change', :via => 'post'

  match 'tasks',            :to => 'tasks#index',   :via => 'get',   :as => :tasks
  match 'tasks',            :to => 'tasks#index',   :via => 'post',  :as => :update_task
  match 'tasks/new',        :to => 'tasks#new',     :via => 'get',   :as => :new_task
  match 'tasks/edit/:id',   :to => 'tasks#edit',    :via => 'get',   :as => :edit_task
  match 'tasks/delete/:id', :to => 'tasks#index',   :via => 'delete',:as => :delete_task

  resources :posts do
    member do
      get :delete
    end
    resources :comments
  end

  devise_for :users

  root :to => "welcome#index"
end


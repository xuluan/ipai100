Ipai100::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "shop_api/login"

  post "shop_api/publish"

  resources :messages do
    get :list, :on => :collection
  end

  get "home/index"

  get "syncs/index" => "syncs#index", :as => :sync_index
  match "syncs/destroy/:id" => "syncs#destroy", :as => :sync_destroy
#  get "syncs/callback"

  match "syncs/:type/new" => "syncs#new", :as => :sync_new
  match "syncs/:type/callback" => "syncs#callback", :as => :sync_callback

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "messages#list"

  match "users/update_info" => "users#update_info", :as => :update_info

  match "users/update_pwd" => "users#update_pwd", :as => :update_pwd
  resources :users




  resources :sessions
end

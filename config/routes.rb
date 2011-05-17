Ipai100::Application.routes.draw do
  get "home/index"

  get "syncs/index" => "syncs#index", :as => :sync_index
  match "syncs/destroy/:id" => "syncs#destroy", :as => :sync_destroy
#  get "syncs/callback"

  match "syncs/:type/new" => "syncs#new", :as => :sync_new
  match "syncs/:type/callback" => "syncs#callback", :as => :sync_callback

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "home#index"
  resources :users
  resources :sessions
end

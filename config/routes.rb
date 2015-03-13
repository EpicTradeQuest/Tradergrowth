Rails.application.routes.draw do
  devise_for :users
  resources :trades
  resources :charges

  get 'charges/unsub' => 'charges#unsub', :as => :unsub_charges

  resources :review
  resources :static_pages
    #get "/review" => "tags#review"

  authenticated :user do
    root :to => "trades#index", :as => "authenticated_root"
  end

  root 'static_pages#index'

  get "privacy", to: "static_pages#privacy", as: :privacy
  get "tos", to: "static_pages#tos", as: :tos
end
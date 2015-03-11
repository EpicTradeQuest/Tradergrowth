Rails.application.routes.draw do
  devise_for :users
  resources :trades
  resources :charges

  get 'charges/unsub' => 'charges#unsub', :as => :unsub_charges
  mount StripeEvent::Engine, at: '/stripe-events'
  resources :review
  resources :static_pages
    #get "/review" => "tags#review"

  authenticated :user do
    root :to => "trades#index", :as => "authenticated_root"
  end

  root 'static_pages#index'

end
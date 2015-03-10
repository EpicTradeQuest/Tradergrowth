Rails.application.routes.draw do
  devise_for :users
  resources :trades
  resources :charges
  get 'charges/unsub' => 'charges#unsub', :as => :unsub_charges
  mount StripeEvent::Engine => '/stripe-events'
  resources :review do
    collection do
        get :autocomplete
    end
  end
    #get "/review" => "tags#review"

  root 'trades#index'
end
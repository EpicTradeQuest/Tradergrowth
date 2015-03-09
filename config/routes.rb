Rails.application.routes.draw do
  devise_for :users
  resources :trades
  resources :charges
  resources :review do
    collection do
        get :autocomplete
    end
  end
    #get "/review" => "tags#review"

  root 'trades#index'
end
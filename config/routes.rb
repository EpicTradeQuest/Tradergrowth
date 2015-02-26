Rails.application.routes.draw do
  resources :trades
  resources :review

    #get "/review" => "tags#review"

  root 'trades#index'
end

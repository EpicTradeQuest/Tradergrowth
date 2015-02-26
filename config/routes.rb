Rails.application.routes.draw do
  resources :trades
  resources :review do
    collection do
        get :autocomplete
    end
  end
    #get "/review" => "tags#review"

  root 'trades#index'
end

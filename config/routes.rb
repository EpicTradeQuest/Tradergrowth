Rails.application.routes.draw do
  resources :trades
  resources :tags

  root 'trades#index'
end

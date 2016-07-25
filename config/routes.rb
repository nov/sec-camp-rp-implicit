Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  get 'callback', to: 'sessions#show'
  root to: 'top#index'
end

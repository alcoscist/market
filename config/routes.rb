Rails.application.routes.draw do
  get 'store/index'

  resources :goods

  root 'store#index', as: 'store'


end

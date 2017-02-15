Rails.application.routes.draw do
  get 'profiles/index'

  get 'profiles/create'

  get 'profiles/backup'

  root to: 'profiles#index'
  devise_for :users
  resources :users
end

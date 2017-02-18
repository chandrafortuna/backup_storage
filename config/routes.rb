Rails.application.routes.draw do
  get 'visitors/index'

  root to: 'profiles#index'
  devise_for :users
  resources :users
  resources :profiles do
    resources :profile_logs do
      get :detail
    end
    post :backup
    get :detail
  end
end

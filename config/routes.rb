Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  #get 'static_pages/help'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'attend'  => 'attendances#new'
  post   'attend'  => 'attendances#create'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end

Rails.application.routes.draw do

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  #get   'static_pages/help'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  get    'login_select_box'   => 'sessions#new2'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'attend'  => 'attendances#new'
  get    'vote'    => 'project_vote#new'

  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :attendances,         only: [:new, :create]
  resources :soukais
  resources :project_vote,        only: [:new, :create]
end

Rails.application.routes.draw do

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  get    'login_select_box'   => 'sessions#new2'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'attend'  => 'attendances#new'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :soukais
  resources :attendances,         only: [:new, :create]
  resources :projects
  resources :votes,        only: [:new, :create] do
    collection do
      get :select_project
      :project_options_select
    end
  end
  resources :send_mails, only: [:index, :create]
end

Rails.application.routes.draw do
  # get 'query/new'

  # get 'queries/new'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  # get "dashboard" => 'static_pages#dashboard'
  # get 'dashboard', to: "static_pages#dashboard_search"
  # get "dashboard/search", to: "static_pages#dashboard_search"
  # get "dashboard/results", to: "static_pages#dashboard_results"  
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'  
  resources :users
  get 'users/:id/dashboard' => 'users#dashboard', as: :dashboard
  # resources :queries
end

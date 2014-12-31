Rails.application.routes.draw do
  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'  
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'  
  # get 'users/:id/dashboard' => 'users#dashboard', as: :dashboard
  post 'customers' => 'customers#create', as: :new_customers # not working right now
  resources :users
  resources :customers,          only: [:create, :destroy, :show]
  resources :pdf_forms
end

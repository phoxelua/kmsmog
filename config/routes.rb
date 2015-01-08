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
  # post 'customers' => 'customers#create', as: :new_customers # not working right now
  # get "users/:user_id/customers/:id" => 'customers#new', as: :new_customer
  resources :users do
    resources :customers,          only: [:create, :destroy, :show, :new, :update, :edit] do
      resources :pdf_forms do
        resources :repairs,        only: [:create, :destroy, :show, :update, :edit]
      end
    end
  end
end

Rails.application.routes.draw do
  root             'users#show'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'  
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'customers/load_prices'
  get 'customers/load_models'
  get 'customers/load_years'  
  get 'users/:id/customers' => 'users#show' 
  # get 'users/:id/dashboard' => 'users#dashboard', as: :dashboard
  # post 'customers' => 'customers#create', as: :new_customers # not working right now
  # get "users/:user_id/customers/:id" => 'customers#new', as: :new_customer
      #   collection do
      #   get :load
      # end  
  resources :users do
    resources :customers,          only: [:create, :destroy, :show, :new, :update, :edit] do     
      resources :pdf_forms do
        resources :repairs,        only: [:create, :destroy, :show, :update, :edit]
      end
    end
  end
end

Rails.application.routes.draw do
  get 'lists/index'
  resources :lists

  get 'contacts/index'
  get 'contacts/download'
  get 'contacts/create_list'
  get 'contacts/search'
  get 'contacts/process_file'
  resources :contacts do
    collection do
      post 'process_file'
      post 'save_list'
      post 'load_to_s3'
      get 'search'
      post 'create_list'
    end
  end
  
  
  delete 'logout',  to: 'sessions#destroy', as: 'logout'
  post   'login',   to: 'sessions#create'
  get    'login',   to: 'sessions#new'
  
  # resources :sessions, only: [:new, :create, :destroy], controller: 'sessions'

  
  root to: "contacts#index"
  
end
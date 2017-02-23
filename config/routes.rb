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
  
  root to: "contacts#index"
  get    'login',   to: 'sessions#new', as: 'login'
  post   '/login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy', as: 'logout'
  
end
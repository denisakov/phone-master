Rails.application.routes.draw do
  # get 'uploads/new'
  # get 'uploads/create'
  # get 'uploads/index'
  # resources :uploads
  resources :lists
  post 'lists/index'
  
  get 'contacts/index'
  get 'contacts/download'
  get 'contacts/create_list'
  get 'contacts/search'
  get 'contacts/process_file'
  resources :contacts do
    collection { post :process_file }
  end
  resources :contacts do
    collection { post :save_list }
  end
  resources :contacts do
    collection { post :load_to_s3 }
  end
  
  resources :contacts do
    collection { post :create_list }
  end
  resources :contacts do
    collection { get :search }
  end
 
  root to: "lists#index"
end
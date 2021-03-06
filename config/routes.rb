Rails.application.routes.draw do

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]


  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get "/posts/new" => "posts#new", as: :new_post
  post "/posts" => "posts#create", as: :posts
  get "/posts/:id" => "posts#show", as: :post
  get "/posts" => "posts#index"
  get "/posts/:id/edit" => "posts#edit", as: :edit_post
  patch "/posts/:id" => "posts#update"
  delete "/posts/:id" => "posts#destroy"

  get "/searches" => "searches#index"


  # get "/comments/new" => "comments#new", as: :new_comment
  post "/comments" => "comments#create", as: :comments
  get "/comments/:id" => "comments#show", as: :comment
  # get "/comments" => "comments#index"
  get "/comments/:id/edit" => "comments#edit", as: :edit_comment
  patch "/comments/:id" => "comments#update"
  delete "/comments/:id" => "comments#destroy"

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

  end

  resources :users, only: [:create, :new, :edit, :update]

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  resources :favorites, only: :index


  get "/users/:id/edit_password" => "users#edit_password", as: :edit_password
  patch "/users/:id/update_password" => "users#update_password", as: :update_password

  resources :password_resets







  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "/register" => "mains#register"
  get "/team_members" => "mains#team_members"
  post 'attachment/upload' => 'attachments#upload'

  resources :mains do
    collection do 
      get :team_members
      get :guide
      get :lp_guide
    end
  end

  resources :users do
    collection do 
      get :contact
      post :send_mail
      get :clause
    end

    member do
      get :upload
      get :upload2
      resources :profiles
    end
  end

  resources :comments
  
  resources :songs do
    collection do
      get :youtube_teach
      get :battle
      get :dojo
    end
    member do
      get :like
    end
  end

  namespace :admin do
    resources :mail_titles
    resources :users do
      collection do
        get :mailbox
      end
    end
    resources :songs
    resources :comments
    resources :notifications
  end

  root :to => 'mains#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

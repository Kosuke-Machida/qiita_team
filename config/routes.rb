Rails.application.routes.draw do

  # diviseでUserを管理 showだけ手書きで追加
  devise_for :users
  root "articles#index"
  resources :users, :only => [:show]

  # Articleに関するroutes
  resources :articles do
    resources :comments, :only => [:new, :edit, :create, :update, :destroy]
    resources :stocks, :only => [:create, :destroy]
  end

  # Groupに関するroutes
  resources :groups do
    resources :group_users, :only => [:new, :create, :update, :destroy]
    get 'managers/search_member', to: 'managers#search_member'
    patch 'manager/update' => 'managers#update'
  end




  # acts_as_taggable_onというGEMでtagを管理
  match 'tags/:tag', to: 'articles#index', as: :tag, via: [:get, :post]
  get 'tags', to: 'tags#index'




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

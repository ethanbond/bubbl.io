Bubblio::Application.routes.draw do

  root to: "bubbles#new"

  match '/team', to: "pages#team"
  match '/terms', to: "pages#terms"
  match '/what', to: "pages#what"

  get "items/new"

  get "items/show"

  get "items/create"

  get "links/new"

  get "links/create"

  # get "links/show"

  get "bubbles/getID"

  get "bubbles/new"

  # "bubbles/show"

  get "bubbles/create"

  get "pages/team"

  get "pages/terms"

  get "pages/what"

  #map.connect "bubbles/:action", :controller => 'bubbles', :action => /[a-z]+/i

  resources :bubbles do
    resources :items
    resources :links
  end
  
 

  # Routes for hashed URL
  match '/*path', to: 'bubbles#show'
  
  match '/ZeroClipboard', to: "public#ZeroClipboard.swf"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

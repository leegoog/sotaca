Sotaca::Application.routes.draw do

  
  get "admin/index"

  resources :article_sets

  resources :product_likes

  resources :translations

  get "users/index"

  get "users/show"

  get "user/index"

  get "user/show"

  resources :payment_notifications

  resources :orders

  resources :line_items

  resources :carts

  devise_for :users, :path_names => { :sign_up => "register"}
  
  resources :users
  
  resources :orders
  
  resources :categories

  resources :products do 
      resources :assets
  end

  resources :assets

  match 'current_cart' => "carts#show", :id => 'current'
  
  match 'log_in' => "users#sign_in"
  
  match 'sets' => "article_sets#index"

  match 'shop' => "products#index"
  
  match 'admin' => "admin#index"
  
  match 'cart/empty' => "carts#empty"

  match 'index' => "pages#index"

  match 'home' => "pages#home"

  match 'just_in' => "pages#just_in"

  match 'info' => "pages#info"

  match 'our_story' => "pages#our_story"

  match 'contact' => "pages#contact"

  match 'terms' => "pages#terms"

  match 'press' => "pages#press"

  match 'whole_sale' => "pages#whole_sale"

  match 'blog' => "pages#blog"
  
  

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
  root :to => "pages#home"


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

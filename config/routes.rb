Sotaca::Application.routes.draw do

  resources :wishlists

  resources :adresses

  resources :order_statuses

  resources :supports, :only => [:new, :create]

  get "profile/show"

  resources :shipping_methods

  resources :article_set_likes
  
  resources :stock_items do
     get :autocomplete_product_title, :on => :collection
  end

  get "set_items/create"

  ActiveAdmin.routes(self)

  resources :article_sets do
    resources :comments
  end

  resources :product_likes

  resources :translations

  get "users/index"

  get "users/show"

  get "user/index"

  get "user/show"
  
  post "products/share_by_mail"

  resources :payment_notifications

  resources :orders, :new => { :express => :get }

  resources :adresses

  resources :line_items

  resources :carts
  
  devise_for :users, :path_names => { :sign_up => "register"}
  
  resources :users do
    resources :adresses
    resources :orders
    resources :article_sets
  end
  
  resources :orders
  
  resources :categories

  resources :products do 
      resources :assets
  end

  resources :assets

  match 'current_cart' => "carts#show", :id => 'current'
  
  match 'log_in' => "users#sign_in"
  
  match 'change_password' => 'users#change_password', :as => 'change_password'
  
  match 'sets' => "article_sets#index"
  
  match 'express_checkout' => "orders#express"

  match 'shop' => "products#index"
  
  match 'shopadmin' => "my_admin#index"
  
  match 'cart/empty' => "carts#empty"

  match 'index' => "pages#index"
  
  match 'wishlist' => "wishlists#show", :as => 'wishlist'
  
  match 'add_to_wishlist' => "users#add_to_wishlist", :as => 'add_to_wishlist'

  match 'home' => "pages#home"

  match 'just_in' => "pages#just_in"

  match 'info' => "pages#info"

  match 'our_story' => "pages#our_story"

  match 'contact' => "pages#contact"

  match 'terms' => "pages#terms"

  match 'press' => "pages#press"

  match 'whole_sale' => "pages#whole_sale"

  match 'blog' => "pages#blog"
  
  match 'profile' => "profile#show"
  
  

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

  authenticate :user do
    mount Resque::Server, :at => "/resque"
  end
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

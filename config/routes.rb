Prrp::Application.routes.draw do

  get "comments/create"

  root :to => 'home#index'
  match 'ad' => 'home#applicant_dashboard'
  
  resources :users do
    resources :proposals do
        put :elect, :on => :member
        delete :unelect, :on => :member
        
        get :review, :on => :collection
    end
  
    collection do
      get :resend_activation
    end
  end
  
  resources :comments
  
  match 'proposals/review' => 'proposals#review', :as => :review_proposals

  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :user_sessions, :except => [:edit]
  
  match '/activate/:activation_code' => 'activations#create', :as => :activate
  
  match 'signup' => 'users#new', :as => :signup
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'forgot_password' => 'password_resets#new', :as =>:forgot_password

  # privileged routes
  match '/ca' => 'campus_admin_controls#edit'
  match '/ca/update' => 'campus_admin_controls#update', :via => [:put]
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

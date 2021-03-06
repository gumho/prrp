Prrp::Application.routes.draw do
  
  # Shared routes
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
  
  # Prrp admin stuff
  resources :terms do
    put :set_current, :on => :member
    put :suspend, :on => :member
  end
  
  get 'proposals/assignment_index' => 'proposals#assignment_index', :as => :assignment_index_proposals
  put 'assignments/multi_update' => 'assignments#multi_update', :as => :multi_update_assignments
  
  resources :term_winners, :only => [:create, :destroy, :index]
  
  # Reviewer stuff
  resources :comments do
    get :create
  end
  
  resources :campus_winners, :only => [:index]
  match 'proposals/review' => 'proposals#review', :as => :review_proposals
  
  match '/campus-control-panel' => 'campus_admin_controls#edit', :as => :campus_control_panel
  match '/campus-control-panel/update' => 'campus_admin_controls#update', :via => [:put], :as => :update_campus_control_panel
  
  # Letters of rec
  resources :letters, :only => [:new, :create, :index, :show, :destroy]
  
  # Account stuff
  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :user_sessions, :except => [:edit]
  
  match '/activate/:activation_code' => 'activations#create', :as => :activate
  
  match 'signup' => 'users#new', :as => :signup
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'forgot_password' => 'password_resets#new', :as =>:forgot_password
  
end

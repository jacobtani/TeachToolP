Rails.application.routes.draw do
   
  get 'error/not_found'

  get 'error/internal_server_error'

  get 'error/missing_authentication'

  devise_for :users, :controllers => {:registrations => "myregistrations"} 
  
  root 'pages#home'
  devise_scope :user do
    patch '/users/:id/edit' => "myregistrations#update", as: :edit_rego
    get '/users/:id/missing_pack' => "myregistrations#missing_pack", as: :missing_pack
    get '/users/:id/general_parent_enquiry' => "myregistrations#general_parent_enquiry", as: :general_parent_enquiry
    get '/users/:id/parent_help_required' => "myregistrations#parent_help_required", as: :parent_help
    get '/users/:id/payment_related_enquiry' => "myregistrations#payment_related_enquiry", as: :payment_related_enquiry
    get '/users/:id/children' => "myregistrations#children", as: :children
    get '/users/:id/suspend' => "myregistrations#suspend", as: :suspend_child
    get '/users/:id/cancel' => "myregistrations#cancel_account", as: :cancel_child
    get '/users/:id/end_trial' => "myregistrations#end_trial", as: :end_trial
    get '/users/:id/redeem_reward' => "myregistrations#redeem_reward", as: :redeem_reward
    get '/users/:id/enter_placement_pack' => "myregistrations#enter_placement_pack", as: :enter_placement_pack
    get '/users/:id/missing_payment' => "myregistrations#missing_payment", as: :missing_payment
    get '/users/:id/recommend_us' => "myregistrations#recommend_us", as: :recommend_us
    get '/users/:id/nullify_rewards' => "myregistrations#nullify_rewards", as: :nullify_rewards
  end

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  match "/401", :to => "errors#not_found", :via => :all

  resources :users_admin, :controller => 'users' do 
    resources :enrolments
  end

  post '/users_admin/create' => "users#create", as: :create_user

  resources :packs
  resources :enclosures

  resources :subjects
  resources :offers
  resources :fees
  resources :messages
  resources :pack_records
  get '/work_missing_email' => "pack_records#work_missing_email", as: :work_missing

  controller :pages do
    get :home
    get :about
    get :delivery_approach
    get :fees_offers
    get :contact
    get :admin
    get :background
    get :expected_roles
    get :mission
    get :terms_conditions
    get :questions
    get :why_extend
    get :communications
    get :historical_view
    get :parent_summary
    get :student_view
    get :employee_view
  end

end

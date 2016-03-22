Rails.application.routes.draw do
   
  get 'error/not_found'

  get 'error/internal_server_error'

  get 'error/missing_authentication'

  devise_for :users, :controllers => {:registrations => "myregistrations"} 
  
  root 'pages#home'
  devise_scope :user do
    patch '/users/:id/edit' => "myregistrations#update", as: :edit_rego
  end

  get '/users/:id/children' => "users#children", as: :children
  get '/users/:id/suspend' => "users#suspend", as: :suspend_child
  get '/users/:id/cancel' => "users#cancel_account", as: :cancel_child
  get '/users/:id/end_trial' => "users#end_trial", as: :end_trial
  get '/users/:id/nullify_rewards' => "users#nullify_rewards", as: :nullify_rewards

  get '/enter_placement_pack' => "users#enter_placement_pack", as: :enter_placement_pack
  post '/enter_placement_pack' => "users#enter_placement_pack"

  post '/users_admin/create' => "users#create", as: :create_user

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  match "/401", :to => "errors#not_found", :via => :all

  get '/messages/missing_pack' => "messages#missing_pack", as: :missing_pack
  get '/messages/general_parent_enquiry' => "messages#general_parent_enquiry", as: :general_parent_enquiry
  get '/messages/parent_help_required' => "messages#parent_help_required", as: :parent_help
  get '/messages/payment_related_enquiry' => "messages#payment_related_enquiry", as: :payment_related_enquiry
  get '/messages/missing_payment' => "messages#missing_payment", as: :missing_payment
  get '/messages/recommend_us' => "messages#recommend_us", as: :recommend_us
  get '/messages/redeem_reward' => "messages#redeem_reward", as: :redeem_reward

  resources :users_admin, :controller => 'users' do 
    resources :enrolments
  end

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

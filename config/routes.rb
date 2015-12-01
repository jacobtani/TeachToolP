Rails.application.routes.draw do
   
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
    get '/users/:id/redeem_reward' => "myregistrations#redeem_reward", as: :redeem_reward
  end 
  
  resources :users do 
    resources :enrolments
  end

  resources :packs do
    resources :enclosures
  end

  resources :ribbons
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
    get :employer_view
  end

end

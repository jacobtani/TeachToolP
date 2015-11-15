Rails.application.routes.draw do
   
  devise_for :users, :controllers => {:registrations => "myregistrations"} 

  root 'pages#home'
  devise_scope :user do
    patch '/users/:id/edit' => "myregistrations#update", as: :edit_rego
  end 
  
  resources :users do 
    resources :enrolments
    get 'student_help_required', to: 'myregistrations#student_help_required', as: :help_student
    get 'parent_help_required', to: 'myregistrations#parent_help_required', as: :help_parent
    get 'general_parent_enquiry', to: 'myregistrations#general_parent_enquiry', as: :parent_enquiry
    get 'missing_pack', to: 'myregistrations#missing_pack', as: :missing_pack
    get 'payment_related_enquiry', to: 'myregistrations#payment_related_enquiry', as: :payment_related_enquiry
  end



  resources :packs do
    resources :enclosures
  end

  resources :ribbons
  resources :subjects
  resources :offers
  resources :messages
  resources :pack_records

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

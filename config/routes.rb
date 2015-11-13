Rails.application.routes.draw do
   
  devise_for :users, :controllers => {:registrations => "myregistrations"}
  root 'pages#home'
   
  resources :users do 
    resources :enrolments
    get 'student_help_required', to: 'myregistrations#student_help_required', as: :help_student

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

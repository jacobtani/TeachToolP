Rails.application.routes.draw do
   
  devise_for :users, :controllers => {:registrations => "tjregistrations"}
  root 'pages#home'
   
  resources :users do 
    resources :pack_records
    resources :enrolments
  end

  resources :packs do
    resources :enclosures
  end

  resources :ribbons
  resources :subjects
  resources :offers

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
  end

end

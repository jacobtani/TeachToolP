Rails.application.routes.draw do
   
  devise_for :users
  root 'pages#home'
   
  resources :users do 
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
  end

end

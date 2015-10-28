Rails.application.routes.draw do
   
  devise_for :users
   root 'pages#home'
   resources :users

  controller :pages do
    get :home
    get :about
    get :delivery_approach
    get :fees_offers
    get :contact
  end

end

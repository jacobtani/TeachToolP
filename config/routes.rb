Rails.application.routes.draw do
   
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

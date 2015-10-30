class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
   # Fields for sign up
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :surname, :role, :postal_address, :email, :password)}
   # Fields for editing an existing account
  # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :gender }
  end

  def is_admin
    !current_user.nil? && current_user.role == 'admin'
  end

end

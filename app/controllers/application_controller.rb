class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
   # Fields for sign up
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:remember_me, :first_name, :surname, :role, :date_of_birth, :postal_address, :city, :state, :zip_code, :contact_email, :contact_phone, :contact_mobile, :email, :password)}
   # Fields for editing an existing account
  # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :gender }
  end

  def admin_only
    user_signed_in? && current_user.role == 'admin'
  end

  def priviliged_only
    user_signed_in? && current_user.role == 'parent'  || current_user.role == 'admin'
  end

  def student_only
    user_signed_in && current_user.role == 'student'
  end

  def redirect_turbo(path)
    render js: "Turbolinks.visit('#{path}')"
  end

end

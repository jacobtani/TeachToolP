class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
   # Fields for sign up
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:remember_me, :first_name, :surname, :role, :school_grade, :date_of_birth, :postal_address, :city, :state, :zip_code, :contact_email, :contact_phone, :contact_mobile, :email, :password)}
   # Fields for editing an existing account
  # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :gender }
  end

  def ensure_admin
    redirect_to root_path, alert: I18n.t("forbidden") unless current_user.admin?
  end

  def ensure_privileged
    redirect_to root_path, alert: I18n.t("forbidden") unless current_user.privileged?
  end

  def ensure_student
    redirect_to root_path, alert: I18n.t("forbidden") unless current_user.student?
  end

  def ensure_parent
    redirect_to root_path, alert: I18n.t("forbidden") unless current_user.parent?
  end

  def not_found!
    render file: "errors/not_found.html.erb", status: :not_found
  end

end

class UsersController < ApplicationController
  before_action :set_user, only: [:update, :show, :destroy]
  before_action :admin_only, only: [:new, :create, :update, :destroy]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    set_parent(@user)
    if @user.save
      build_enrolment_user_data(@user)
      #UserMailer.registration_confirmation_to_user(@user).deliver_now
      #AdminMailer.registration_confirmation_to_admin(@user).deliver_now
      flash[:success] = "User was created successfully."
      redirect_to parent_summary_path
    else
      format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        flash[:success] = "User was updated successfully."
        redirect_to root_path
      else
        redirect_to root_path
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :surname, :role, :parent_id, :school_grade, :status, :additional_info, :postal_address, :email, :password, :city, :state, :zip_code, :phone_number, :contact_email, :contact_phone, :contact_mobile, :date_of_birth, :referrer_email, :activation_date, enrolments_attributes: [:id, :subject_id, :grade, :offer_id, :ability_level, :_destroy])
  end

  def set_user
    @user = User.find params[:id] rescue nil
    return not_found! unless @user
  end

  def set_parent(user)
    user.parent_id = current_user.id if user_signed_in? && current_user.role == 'parent'
  end

  def build_enrolment_user_data(user)
    if user.enrolments && user.role == 'student'
      user.enrolments.each do |e|
        e.date = Date.today
        e.user_id = user.id
        e.start_date = Date.today
        user.payment_due = Date.today + 1.month
        Enrolment.validate_offer(user, e)
        e.save
      end
    end
  end

end

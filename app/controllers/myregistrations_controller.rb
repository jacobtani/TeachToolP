class MyregistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
#  before_action :admin_only, only: [:new, :create, :update, :destroy]
  
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
    set_parent if @user.role == 'student'
    if current_user
      respond_to do |format| 
        if @user.save
          flash[:success] = "User was created successfully."
          UserMailer.registration_confirmation_to_user(@user).deliver_now
          AdminMailer.registration_confirmation_to_admin(@user).deliver_now
          if current_user 
            format.js { redirect_turbo parent_summary_path }
          else
            format.js { redirect_turbo root_path }
          end
        else
          format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
        end
      end
    else
      @user.save
      UserMailer.registration_confirmation_to_user(@user).deliver_now
      AdminMailer.registration_confirmation_to_admin(@user).deliver_now
      redirect_to user_session_path
    end
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @user.update_attributes user_params
        flash[:success] = "User was updated successfully."
        format.js {redirect_turbo users_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def student_help_required(message)
    AdminMailer.student_enquiry(current_user, message).deliver_now
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :surname, :role, :parent_id, :postal_address, :email, :password, :city, :state, :zip_code, :phone_number, :contact_email, :contact_phone, :contact_mobile, :date_of_birth)
  end

  def set_user
    @user = User.find params[:id] rescue nil
    return not_found! unless @user
  end

  def set_parent
    @user.parent_id = current_user.id if user_signed_in? && current_user.role == 'parent'
  end

end
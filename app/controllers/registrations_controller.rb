class RegistrationsController < Devise::RegistrationsController
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
    binding.pry
  end

   def create
    binding.pry
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        flash[:success] = "User was created successfully."
        #session[:user_id] = @user.id
        format.js {redirect_turbo users_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
      end
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

  private 

  def user_params
    set_parent if params[:user][:role] == 'student'
    params.require(:user).permit(:first_name, :surname, :role, :parent_id, :email, :password, :city, :state, :zip_code, :phone_number, :contact_email, :contact_phone, :contact_mobile, :date_of_birth)
  end

  def set_user
    @user = User.find params[:id] rescue nil
    return not_found! unless @user
  end

  def set_parent
    #binding.pry
    self.parent_id = current_user.id if user_signed_in? && current_user.role == 'parent'
  end

end
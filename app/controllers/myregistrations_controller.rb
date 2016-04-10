class MyregistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :show]

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
    respond_to do |format|
      if @user.save
        flash[:success] = "User was created successfully."
        format.html { redirect_to root_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end
  
  def update
    if @user.update_attributes user_params
      flash[:success] = "User was updated successfully."
      redirect_to root_path
    else
        render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User account deleted successfully'
    redirect_to root_path  
  end

  private 

    def user_params
      params.require(:user).permit(:first_name, :surname, :role, :status, :email, :password, :postal_address, :city, :state, :zip_code, :phone_number)
    end

    def set_user
      @user = User.find params[:id] rescue nil
      return not_found! unless @user
    end

end
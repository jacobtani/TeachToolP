class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        format.js { redirect_turbo user_path(@user) }
      else
        #format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        flash[:success] = "User was updated successfully."
        format.js {}
      else
       # format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
      end
    end
  end


  def destroy
    @user.destroy
    #redirect_to users_path
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :surname, :role, :email, :password)
  end

end

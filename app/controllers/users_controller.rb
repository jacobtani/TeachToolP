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
    if @user.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        flash[:success] = "User was updated successfully."
        redirect_to root_path
        #format.js {}
      else
        redirect_to root_path
        #format.js { render partial: 'shared/ajax_form_errors', locals: {model: @site}, status: 500 }
      end
    end
  end


  def destroy
    @user.destroy
    redirect_to root_path
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :surname, :role, :email, :password)
  end

  def set_user
    @user = User.find params[:id] rescue nil
    return not_found! unless @user
  end


end

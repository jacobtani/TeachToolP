 class EnrolmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrolment, only: [:edit, :update, :show, :destroy]
  before_action :set_user, only: [:new, :create, :edit, :update, :index, :show]

  def index
    @enrolments = @user.enrolments
  end

  def show
    @enrolment = @user.enrolments.find (params[:id])
  end

  def new
    @enrolment  = Enrolment.new
  end

  def destroy
    @enrolment.destroy
    UserMailer.send_enrolment_deletion(@enrolment.user).deliver_now
    redirect_to parent_summary_path
  end

  private

    def enrolment_params
      params.require(:enrolment).permit(:user_id, :grade, :subject_id, :fees, :offer_id, :ability_level)
    end
    
    def set_enrolment
      @enrolment = Enrolment.find params[:id] rescue nil
      return not_found! unless @enrolment
    end

    def set_user
      @user = User.find params[:user_id] 
      return not_found! unless @user
    end

end
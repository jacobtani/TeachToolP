 class EnrolmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrolment, only: [:edit, :update, :show, :destroy]
  before_action :set_user, only: [:new, :create]
  #before_action :priviliged_only, only: [:new, :create, :update, :destroy]
  
  def index
    @enrolments = Enrolment.all
  end

  def show
    @enrolment = @user.enrolments.find (params[:id])
  end

  def new
    @enrolment  = Enrolment.new
  end

    def create
    @enrolment = Enrolment.new enrolment_params
    @enrolment.date = Date.today
    @enrolment.user_id = params[:enrolment][:user_id]
    @user_enrolled = User.find(params[:enrolment][:user_id])
    @user_enrolled.enrolments << @enrolment
    @enrolment.fees = 98
    respond_to do |format|
      if @enrolment.save
        @user_enrolled.save
        flash[:success] = "Enrolment was created successfully."
        format.js { redirect_turbo parent_summary_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @enrolment}, status: 500 }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @enrolment.update_attributes enrolment_params
        flash[:success] = "Enrolment was updated successfully."
        redirect_to root_path
        #format.js {}
      else
        redirect_to root_path
        #format.js { render partial: 'shared/ajax_form_errors', locals: {model: @site}, status: 500 }
      end
    end
  end

  def destroy
    @enrolment.destroy
    redirect_to root_path
  end

  private

    def enrolment_params
      params.require(:enrolment).permit(:user_id, :grade, :subject_id, :fees)
    end
    
    def set_enrolment
      @enrolment = Enrolment.find params[:id] rescue nil
      return not_found! unless @enrolment
    end

    def set_user
      @user = current_user if user_signed_in?
      return not_found! unless @user
    end

end
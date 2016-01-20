 class EnrolmentsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_enrolment, only: [:edit, :update, :show, :destroy]
  before_action :set_user, only: [:new, :create, :edit, :update, :index]
  #before_action :priviliged_only, only: [:new, :create, :update, :destroy]

  def index
    @enrolments = @user.enrolments
    respond_to do |format|
      format.js { }
    end
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
    @user_enrolled.payment_due = Date.today + 1.month
    respond_to do |format|
      if @enrolment.save
        @user_enrolled.save
        flash[:success] = "Enrolment was created successfully."
        format.js { redirect_turbo parent_summary_path}
      else
        flash[:error] = 'Enrolment can only be created once per subject per user'
        format.js { redirect_turbo parent_summary_path } 
        #render partial: 'shared/ajax_form_errors', locals: {model: @enrolment}, status: 500 }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @enrolment.update_attributes enrolment_params
        flash[:success] = "Enrolment was updated successfully."
        format.js { redirect_turbo parent_summary_path }
      else
        redirect_to root_path
        #format.js { render partial: 'shared/ajax_form_errors', locals: {model: @site}, status: 500 }
      end
    end
  end

  def destroy
    @enrolment.destroy
    redirect_to parent_summary_path
  end

  private

    def enrolment_params
      params.require(:enrolment).permit(:user_id, :grade, :subject_id, :fees, :offer_id)
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
 class EnrolmentsController < ApplicationController
  before_action :set_enrolment, only: [:update, :show, :destroy]
  before_action :admin_only, only: [:new, :create, :update, :destroy]
  
  def index
    @enrolments = Enrolment.all
  end

  def show
    @enrolment = Enrolment.find(params[:id])
  end

  def new
    @enrolment  = Enrolment.new
  end

  def create
    @enrolment = Enrolment.new enrolment_params
    if @enrolment.save
      redirect_to root_path
    else
      redirect_to root_path
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
      params.require(:enrolment).permit(:person, :subject)
    end
    
    def set_enrolment
      @enrolment = Enrolment.find params[:id] rescue nil
      return not_found! unless @enrolment
    end


end
 class SubjectsController < ApplicationController
  before_action :set_subject, only: [:edit, :update, :show, :destroy]
  #before_action :admin_only, only: [:new, :create, :update, :destroy]
  
  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    respond_to do |format|
      if @subject.save
        flash[:success] = "Subject was created successfully."
        format.js { redirect_turbo subjects_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @subject}, status: 500 }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @subject.update_attributes subject_params
        flash[:success] = "Subject was updated successfully."
        format.js {redirect_turbo subjects_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @site}, status: 500 }
      end
    end
  end

  def destroy
    @subject.destroy
    redirect_to subjects_path
  end

  private

    def subject_params
      params.require(:subject).permit(:subject_name, :fee)
    end

    def set_subject
      @subject = Subject.find params[:id] rescue nil
      return not_found! unless @subject
    end

end
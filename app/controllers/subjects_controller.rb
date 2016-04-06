 class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subject, only: [:edit, :update, :show, :destroy]
  before_action :ensure_admin, only: [:new, :index, :show, :create, :update, :edit, :destroy]
  
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
        format.html { redirect_to admin_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update_attributes subject_params
        flash[:success] = "Subject was updated successfully."
        format.html { redirect_to admin_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @subject.destroy
    redirect_to admin_path
  end

  private

    def subject_params
      params.require(:subject).permit(:subject_name, :fee_id, :highest_grade_taught, :lowest_grade_taught)
    end

    def set_subject
      @subject = Subject.find params[:id] rescue nil
      return not_found! unless @subject
    end

end
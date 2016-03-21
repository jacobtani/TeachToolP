 class EnclosuresController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_enclosure, only: [:edit, :update, :show, :destroy]
  before_action :admin_only, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @enclosures = Enclosure.all
  end

  def show
    @enclosure = Enclosure.find(params[:id])
  end

  def new
    @enclosure  = Enclosure.new
  end

  def create
    @enclosure = Enclosure.new enclosure_params
    respond_to do |format|
      if @enclosure.save
        flash[:success] = "Enclosure was created successfully."
        format.html { redirect_to admin_path }
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @enclosure}, status: 500 }
      end
    end
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @enclosure.update_attributes enclosure_params
        flash[:success] = "Enclosure was updated successfully."
        format.html { redirect_to admin_path }
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @enclosure}, status: 500 }
      end
    end
  end

  def destroy
    @enclosure.destroy
    redirect_to admin_path
  end

  private

    def enclosure_params
      params.require(:enclosure).permit(:name, :subject, :pack_id, :barcode, :due_date)
    end

    def set_enclosure
      @enclosure = Enclosure.find params[:id] rescue nil
      return not_found! unless @enclosure
    end


end
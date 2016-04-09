 class EnclosuresController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_enclosure, only: [:edit, :update, :show, :destroy]
  before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy, :index, :show]
  
  def index
    @enclosures = Enclosure.all
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
        format.html { render :new }
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
        format.html { render :edit }
      end
    end
  end

  def destroy
    @enclosure.destroy
    redirect_to admin_path
  end

  private

    def enclosure_params
      params.require(:enclosure).permit(:name, :barcode, :due_date, :pack_id, :status)
    end

    def set_enclosure
      @enclosure = Enclosure.find params[:id] rescue nil
      return not_found! unless @enclosure
    end


end
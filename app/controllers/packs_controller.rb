class PacksController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_pack, only: [:edit, :update, :show, :destroy]
  before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy, :index, :show]
  
  def index
    @packs = Pack.all
  end

  def new
    @pack  = Pack.new
  end

  def create
    @pack = Pack.new pack_params
    respond_to do |format|
      if @pack.save
        flash[:success] = "Pack was created successfully."
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
      if @pack.update_attributes pack_params
        flash[:success] = "Pack was updated successfully."
        format.html { redirect_to admin_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pack.destroy
    redirect_to admin_path
  end

  private

    def pack_params
      params.require(:pack).permit(:name, :description, :number_unassigned, :number_assigned, :action_required, :subject_id, :pack_type, :priority)
    end

    def set_pack
      @pack = Pack.find params[:id] rescue nil
      return not_found! unless @pack
    end


end
class PacksController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_pack, only: [:edit, :update, :show, :destroy]
  before_action :admin_only, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @packs = Pack.all
  end

  def show
    @pack = Pack.find(params[:id])
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
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @pack}, status: 500 }
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
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @pack}, status: 500 }
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
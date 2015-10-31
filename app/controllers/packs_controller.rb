class PacksController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_pack, only: [:update, :show, :destroy]
  before_action :admin_only, only: [:new, :create, :update, :destroy]
  
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
    @pack = Pack.new enclosure_params
    if @pack.save
      redirect_to root_path
    else
      redirect_to root_path
  end

    def update
    respond_to do |format|
      if @pack.update_attributes pack_params
        flash[:success] = "Pack was updated successfully."
        redirect_to root_path
        #format.js {}
      else
        redirect_to root_path
        #format.js { render partial: 'shared/ajax_form_errors', locals: {model: @site}, status: 500 }
      end
    end
  end

  def destroy
    @pack.destroy
    redirect_to root_path
  end

  private

    def pack_params
      params.require(:pack).permit(:name, :subject)
    end

    def set_pack
      @pack = Pack.find params[:id] rescue nil
      return not_found! unless @pack
    end


end
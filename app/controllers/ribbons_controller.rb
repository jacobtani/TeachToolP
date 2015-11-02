 class RibbonsController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_ribbon, only: [:update, :show, :destroy]
  before_action :admin_only, only: [:new, :create, :update, :destroy]
  
  def index
    @ribbons = Ribbon.all
  end

  def show
    @ribbon = Ribbon.find(params[:id])
  end

  def new
    @ribbon  = Ribbon.new
  end

  def create
    @ribbon = Ribbon.new ribbon_params
    if @ribbon.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @ribbon.update_attributes ribbon_params
        flash[:success] = "Ribbon was updated successfully."
        redirect_to root_path
        #format.js {}
      else
        redirect_to root_path
        #format.js { render partial: 'shared/ajax_form_errors', locals: {model: @site}, status: 500 }
      end
    end
  end

  def destroy
    @ribbon.destroy
    redirect_to root_path
  end

  private

    def ribbon_params
      params.require(:ribbon).permit(:name, :subject)
    end

    def set_ribbon
      @ribbon = Ribbon.find params[:id] rescue nil
      return not_found! unless @ribbon
    end

end
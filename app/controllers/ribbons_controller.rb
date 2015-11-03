 class RibbonsController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_ribbon, only: [:edit, :update, :show, :destroy]
#  before_action :admin_only, only: [:new, :create, :update, :destroy]
  
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
    respond_to do |format|
      if @ribbon.save
        flash[:success] = "Ribbon was created successfully."
        format.js { redirect_turbo admin_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @ribbon}, status: 500 }
      end
    end
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @ribbon.update_attributes ribbon_params
        flash[:success] = "Ribbon was updated successfully."
        format.js {redirect_turbo admin_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @ribbon}, status: 500 }
      end
    end
  end

  def destroy
    @ribbon.destroy
    redirect_to root_path
  end

  private

    def ribbon_params
      params.require(:ribbon).permit(:name, :subject_id)
    end

    def set_ribbon
      @ribbon = Ribbon.find params[:id] rescue nil
      return not_found! unless @ribbon
    end

end
 class FeesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_fee, only: [:edit, :update, :show, :destroy]
  before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @fees = Fee.all
  end

  def new
    @fee  = Fee.new
  end

  def create
    @fee = Fee.new fee_params
    respond_to do |format|
      if @fee.save
        flash[:success] = "Fee was created successfully."
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
      if @fee.update_attributes fee_params
        flash[:success] = "Fee was updated successfully."
        format.html { redirect_to admin_path }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @fee.destroy
    redirect_to admin_path
  end

  private

    def fee_params
      params.require(:fee).permit(:fee_name, :start_date, :end_date, :amount, :fee_type, :subject_id)
    end

    def set_fee
      @fee = Fee.find params[:id] rescue nil
      return not_found! unless @fee
    end

end
 class OffersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_offer, only: [:update, :show, :destroy]
  before_action :admin_only, only: [:new, :create, :update, :destroy]
  
  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer  = Offer.new
  end

  def create
    @offer = Offer.new offer_params
    if @offer.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def update
    respond_to do |format|
      if @offer.update_attributes offer_params
        flash[:success] = "Offer was updated successfully."
        redirect_to root_path
        #format.js {}
      else
        redirect_to root_path
        #format.js { render partial: 'shared/ajax_form_errors', locals: {model: @site}, status: 500 }
      end
    end
  end

  def destroy
    @offer.destroy
    redirect_to root_path
  end

  private

    def offer_params
      params.require(:offer).permit(:name, :description, :start_date, :end_date, :includes_trial)
    end

    def set_offer
      @offer = Offer.find params[:id] rescue nil
      return not_found! unless @offer
    end


    def 

end
 class OffersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_offer, only: [:edit, :update, :show, :destroy]
 # before_action :admin_only, only: [:new, :create, :update, :destroy]
  
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
    respond_to do |format|
      if @offer.save
        flash[:success] = "Offer was created successfully."
        format.js { redirect_turbo admin_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @offer}, status: 500 }
      end
    end
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @offer.update_attributes offer_params
        flash[:success] = "Offer was updated successfully."
        format.js {redirect_turbo admin_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @offer}, status: 500 }
      end
    end
  end

  def destroy
    @offer.destroy
    redirect_to admin_path
  end

  private

    def offer_params
      params.require(:offer).permit(:offer_name, :offer_description, :start_date, :end_date, :includes_free_trial, :discount_amount, :percentage_discount, :number_of_subjects)
    end

    def set_offer
      @offer = Offer.find params[:id] rescue nil
      return not_found! unless @offer
    end

end
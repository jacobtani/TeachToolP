 class OffersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_offer, only: [:edit, :update, :show, :destroy]
  before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy]
  
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
        format.html { redirect_to admin_path }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @offer.update_attributes offer_params
        flash[:success] = "Offer was updated successfully."
        format.html { redirect_to admin_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @offer.destroy
    redirect_to admin_path
  end

  private

    def offer_params
      params.require(:offer).permit(:offer_name, :offer_description, :start_date, :end_date, :includes_free_trial, :discount_monthly, :discount_enrolment, :percentage_enrolment, :percentage_monthly, :number_of_subjects, :subject_id)
    end

    def set_offer
      @offer = Offer.find params[:id] rescue nil
      return not_found! unless @offer
    end

end
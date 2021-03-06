require 'tempfile'

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :destroy, :edit, :update, :children, :suspend, :cancel_account, :end_trial, :redeem_reward, :payment_received, :register_fees_overdue]
  before_action :ensure_not_student, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :ensure_privileged, only: [:register_fees_overdue, :enter_placement_pack, :suspend, :nullify_rewards, :payment_received]
  before_action :ensure_parent, only: [:cancel_account, :end_trial]
  before_action :ensure_admin, only: [:login_as]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @user.enrolments.build
  end

  def create
    @user = User.new user_params
    set_parent(@user)
    respond_to do |format|
      if @user.save
        build_enrolment_user_data(@user)
        UserMailer.registration_confirmation_to_user(@user).deliver_now
        AdminMailer.registration_confirmation_to_admin(@user).deliver_now
        flash[:success] = "User was created successfully."
        format.html { redirect_to root_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        build_enrolment_user_data(@user)
        flash[:success] = "User was updated successfully."
        format.html { redirect_to root_path }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @user.destroy
    redirect_to root_path
  end

  def enter_placement_pack
    @students = User.students
    @user = User.find(params[:student]).full_name if params[:student]
    respond_to do |format|
      format.html       
      format.pdf do
        data = render_to_string pdf: "filename", template: "/users/enter_placement_pack.pdf.erb", encoding: "UTF-8", footer: { right: '[page] of [topage]' }
        filename = "PlacementPack--" + @user
        filename.gsub!(/ /,'-')
        begin 
          file = Tempfile.new([filename, '.pdf']) 
          file.binmode
          file.write data
          send_file file.path
        ensure
          file.close
        end
      end
    end
  end

  def suspend
    @user.update(status: 1)
    UserMailer.suspension_email(@user).deliver_now
    redirect_to root_path
  end

  def end_trial
    @user.update(status: 3)
    redirect_to parent_summary_path
  end

  def nullify_rewards
    ValidatorMod.nullify_rewards
    flash[:success] = "Rewards have been successfully put to $0.00"
    redirect_to employee_view_path
  end

  def login_as
    return unless current_user.role == 'admin'
    sign_in(:user, User.find(params[:id]))
    flash[:success]= 'Logged in successfully'
    redirect_to root_path
  end

  def payment_received
    payment_due = @user.payment_due
    @user.update(last_payment_date: Date.today, payment_due: payment_due + 1.month)
    redirect_to root_path
  end

  def register_fees_overdue
    fees = @user.account_balance
    @user.update(overdue_fees: fees)
    total_monthly_fees = @user.total_fees
    @user.update(account_balance: total_monthly_fees )
  end

  private 

    def user_params
      params.require(:user).permit(:first_name, :surname, :role, :parent_id, :school_grade, :status, :additional_info, :postal_address, :email, :password, :city, :state, :zip_code, :phone_number, :contact_email, :contact_phone, :contact_mobile, :date_of_birth, :referrer_email, :activation_date, enrolments_attributes: [:id, :subject_id, :grade, :offer_id, :ability_level, :date, :_destroy])
    end

    def set_user
      @user = User.find params[:id] rescue nil
      return not_found! unless @user
    end

    def set_parent(user)
      user.parent_id = current_user.id if user_signed_in? && current_user.role == 'parent'
    end

    def build_enrolment_user_data(user)
      if user.enrolments && user.role == 'student'
        user.enrolments.recent.each do |e|
          e.update(date: Date.today)
          e.update(created_at: Time.now - 10.minutes)
          user.payment_due = Date.today + 1.month
          Enrolment.validate_offer(user, e)
        end
      end
    end

end
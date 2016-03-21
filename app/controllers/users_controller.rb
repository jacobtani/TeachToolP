require 'tempfile'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update, :children, :suspend, :cancel_account, :end_trial, :redeem_reward, :missing_payment]
  
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
        #UserMailer.registration_confirmation_to_user(@user).deliver_now
        #AdminMailer.registration_confirmation_to_admin(@user).deliver_now
        flash[:success] = "User was created successfully."
        format.html { redirect_to parent_summary_path }
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        flash[:success] = "User was updated successfully."
        format.html { redirect_to parent_summary_path }
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
      end
    end
  end


  def destroy
    @user.destroy
    redirect_to root_path
  end

  def enter_placement_pack
    @students = User.students
    respond_to do |format|
      format.html       
      format.pdf do
        data = render_to_string pdf: "filename", template: "/myregistrations/enter_placement_pack.pdf.erb", encoding: "UTF-8", footer: { right: '[page] of [topage]' }
        filename = "Test--StatusReport--"
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

  def children
    @children = @user.children if current_user.role == 'parent'
  end

  def suspend
    @user.update(status: 1)
    UserMailer.suspension_email(@user).deliver_now
    redirect_to users_path
  end

  def cancel_account
    @user.update(status: 2)
    redirect_to parent_summary_path
  end

  def end_trial
    @user.update(status: 3)
    redirect_to parent_summary_path
  end

  def send_email_to_user
  end

  def nullify_rewards
    ValidatorMod.nullify_rewards
    redirect_to employee_view_path
  end

  private 

    def user_params
      params.require(:user).permit(:first_name, :surname, :role, :parent_id, :school_grade, :status, :additional_info, :postal_address, :email, :password, :city, :state, :zip_code, :phone_number, :contact_email, :contact_phone, :contact_mobile, :date_of_birth, :referrer_email, :activation_date, enrolments_attributes: [:id, :subject_id, :grade, :offer_id, :ability_level, :_destroy])
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
        user.enrolments.each do |e|
          e.date = Date.today
          e.user_id = user.id
          e.start_date = Date.today
          user.payment_due = Date.today + 1.month
          Enrolment.validate_offer(user, e)
          e.save
        end
      end
    end

end

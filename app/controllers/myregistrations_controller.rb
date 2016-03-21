require 'tempfile'
class MyregistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:edit, :update, :show, :destroy, :children, :suspend, :cancel_account, :end_trial, :redeem_reward, :missing_payment]
  
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
    if @user.save
      flash[:success] = "User was created successfully."
      redirect_to root_path
    else
      format.js { render partial: 'shared/ajax_form_errors', locals: {model: @user}, status: 500 }
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
    redirect_to users_path  
  end

  def student_help_required
    respond_to do |format|
      format.js { }
    end
      end

  def parent_help_required
    respond_to do |format|
      format.js { }
    end
  end

  def missing_pack
    respond_to do |format|
      format.js { }
    end
  end

  def payment_related_enquiry
      respond_to do |format|
      format.js { }
    end
  end

  def general_parent_enquiry
    respond_to do |format|
      format.js { }
    end
  end

  def children
    @children = @user.children if current_user.role == 'parent'
    respond_to do |format|
      format.js {}
    end
  end

  def suspend
    @user.status = 1
    @user.save
    UserMailer.suspension_email(@user).deliver_now
    redirect_to users_path
  end

  def cancel_account
    @user.status = 2
    @user.save
    respond_to do |format|
      format.js { }
    end
  end

  def end_trial
    @user.status = 3
    @user.save
    respond_to do |format|
      format.js { redirect_turbo parent_summary_path }
    end
  end

  def missing_payment
    UserMailer.missing_payment(@user).deliver_now
    redirect_to parent_summary_path
  end

  def redeem_reward
    AdminMailer.redeem_reward(@user, @user.rewards).deliver_now
    @user.rewards = 0.00
    @user.activation_date = Date.today
    @user.save
    redirect_to parent_summary_path
  end

  def send_email_to_user
  end

  def recommend_us
    respond_to do |format|
      format.js { }
    end
  end

  def nullify_rewards
    ValidatorMod.nullify_rewards
    redirect_to employee_view_path
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

  private 

  def user_params
    params.require(:user).permit(:first_name, :surname, :role, :parent_id, :school_grade, :status, :additional_info, :postal_address, :email, :password, :city, :state, :zip_code, :phone_number, :contact_email, :contact_phone, :contact_mobile, :date_of_birth, :referrer_email, enrolments_attributes: [:id, :subject_id, :grade, :offer_id, :ability_level, :_destroy])
  end

  def set_user
    @user = User.find params[:id] rescue nil
    return not_found! unless @user
  end


end
class MessagesController < ApplicationController
  before_action :authenticate_user!  
  before_action :ensure_parent, only: [:parent_help_required, :missing_pack, :general_parent_enquiry, :payment_related_enquiry, :recommend_us]
  before_action :ensure_student, only: [:student_help_required, :redeem_reward]
  before_action :ensure_privileged, only: [:send_user_message]
  before_action :set_user, only: [:missing_payment, :cancel_account]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.valid?
      send_message(current_user, @message)
      flash[:success] = "Message sent successfully"
    else
      render "new"
    end
  end

  def send_message(user, message)
    @child = User.find(params[:message][:child]) if params[:message][:child]

    if message.message_subject == 'STUDENT NEEDS HELP'
      AdminMailer.student_needs_help(current_user, message).deliver_now
      redirect_to student_view_path

    elsif message.message_subject == 'PARENT NEEDS HELP'
      AdminMailer.parent_needs_help(current_user, @child, message).deliver_now
      redirect_to parent_summary_path
    
    elsif message.message_subject == 'MISSING PACK/WORK'
      AdminMailer.missing_pack(current_user, @child, message).deliver_now
      redirect_to parent_summary_path
    
    elsif message.message_subject == 'PAYMENT RELATED'
      AdminMailer.payment_related_enquiry(current_user, @child, message).deliver_now
      redirect_to parent_summary_path

    elsif message.message_subject == 'GENERAL CORRESPONDENCE'
      AdminMailer.general_parent_enquiry(current_user, message).deliver_now
      redirect_to parent_summary_path
    
   elsif message.message_subject == 'TERMINATED ACCOUNT'
      UserMailer.cancel_child_account(@child, message).deliver_now
      AdminMailer.student_cancelled_account(@child, message).deliver_now
      redirect_to parent_summary_path
    
    elsif message.message_subject == 'SEND EMAIL TO USER'
      UserMailer.send_email_to_user(message).deliver_now
      redirect_to employee_view_path
    
    elsif message.message_subject == 'RECOMMEND US'
      UserMailer.recommend_us(current_user, message).deliver_now
      redirect_to parent_summary_path
    end
  end

  def student_help_required
    @message = Message.new
  end

  def parent_help_required
    @message = Message.new
  end

  def missing_pack
    @message = Message.new
  end

  def payment_related_enquiry
    @message = Message.new
  end

  def general_parent_enquiry
    @message = Message.new
  end

  def recommend_us
    @message = Message.new
  end

  def send_user_message
    @message = Message.new
  end

  def missing_payment
    UserMailer.missing_payment(@user).deliver_now
    redirect_to parent_summary_path
  end

  def cancel_account
    @user.update(status: 2)
    @message = Message.new
  end


  def redeem_reward
    @student = User.find(params[:id])
    AdminMailer.redeem_reward(@student, @student.rewards).deliver_now
    @student.update(rewards: 0, activation_date: Date.today)
    redirect_to parent_summary_path
  end


  private 

    def message_params
      params.require(:message).permit(:content, :pack_name, :message_recipient_name, :child, :page_number, :question_number, :subject_name, :subject, :message_subject, :message_recipient)
    end

    def set_user
      @user = User.find params[:user_id] rescue nil
      return not_found! unless @user
    end

end
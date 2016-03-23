class MessagesController < ApplicationController

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
    if @message.message_subject == 'STUDENT NEEDS HELP'
      AdminMailer.student_enquiry(current_user, @message).deliver_now
      redirect_to student_view_path
    elsif @message.message_subject == 'MISSING PACK/WORK'
      AdminMailer.missing_pack(current_user, @message).deliver_now
      redirect_to parent_summary_path
    elsif @message.message_subject == 'GENERAL CORRESPONDENCE'
      AdminMailer.general_parent_enquiry(current_user, @message).deliver_now
      redirect_to parent_summary_path
    elsif @message.message_subject == 'PARENT NEEDS HELP'
      AdminMailer.parent_help_required(current_user, @message).deliver_now
      redirect_to parent_summary_path
    elsif @message.message_subject == 'PAYMENT RELATED'
      AdminMailer.payment_related_enquiry(current_user, @message).deliver_now
      redirect_to parent_summary_path
    elsif @message.message_subject == 'TERMINATED ACCOUNT'
      binding.pry
      UserMailer.cancellation_email(current_user, @message).deliver_now
      AdminMailer.student_cancelled_acount(current_user, @message).deliver_now
      redirect_to parent_summary_path
    elsif @message.message_subject == 'SEND EMAIL TO USER'
      UserMailer.send_email_to_user(@message).deliver_now
      redirect_to employee_view_path
    elsif @message.message_subject == 'RECOMMEND US'
      UserMailer.recommend_us(current_user, @message).deliver_now
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

  def missing_payment
    UserMailer.missing_payment(@user).deliver_now
    redirect_to parent_summary_path
  end

  def redeem_reward
    AdminMailer.redeem_reward(@user, @user.rewards).deliver_now
    @user.update(rewards: 0, activation_date: Date.today)
    redirect_to parent_summary_path
  end

  private 

    def message_params
      params.require(:message).permit(:content, :pack_name, :message_recipient_name, :page_number, :question_number, :subject_name, :subject, :message_subject, :message_recipient)
    end

end
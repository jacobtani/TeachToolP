class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.valid?
      if @message.message_subject == 'STUDENT NEEDS HELP'
        AdminMailer.student_enquiry(current_user, @message).deliver_now
        redirect_to student_view_path, notice: "Message sent!"
      elsif @message.message_subject == 'PARENT NEEDS HELP'
        AdminMailer.parent_enquiry(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'MISSING PACK/WORK'
        AdminMailer.missing_pack(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'PARENT GENERAL QUESTION'
        AdminMailer.general_parent_enquiry(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'PAYMENT RELATED MATTERS'
        AdminMailer.payment_related_enquiry(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'TERMINATED ACCOUNT'
        UserMailer.cancellation_email(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'SEND EMAIL TO USER'
        UserMailer.send_email_to_user(@message).deliver_now
        redirect_to employee_view_path
      end
    else
      render "new"
    end
  end

  private 

  def message_params
    params.require(:message).permit(:content, :pack_name, :message_recipient_name, :page_number, :question_number, :subject_name, :subject, :message_subject, :message_recipient)
  end

end
class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.valid?
      if @message.message_subject == 'Student Help'
        AdminMailer.student_enquiry(current_user, @message).deliver_now
        redirect_to student_view_path, notice: "Message sent!"
      elsif @message.message_subject == 'Parent Help'
        AdminMailer.parent_enquiry(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'Missing Pack'
        AdminMailer.missing_pack(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'General Parent Enquiry'
        AdminMailer.general_parent_enquiry(current_user, @message).deliver_now
        redirect_to parent_summary_path
      elsif @message.message_subject == 'Payment Related Enquiry'
        AdminMailer.payment_related_enquiry(current_user, @message).deliver_now
        redirect_to parent_summary_path
      end
    else
      render "new"
    end
  end

  private 

  def message_params
    params.require(:message).permit(:content, :pack_name, :page_number, :question_number, :subject_name, :message_subject)
  end

end
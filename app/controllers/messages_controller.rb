class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.valid?
      if current_user.role == 'student'
        AdminMailer.student_enquiry(current_user, @message).deliver_now
        redirect_to student_view_path, notice: "Message sent!"
      elsif current_user.role == 'parent'
        AdminMailer.parent_enquiry(current_user, @message).deliver_now
        redirect_to parent_summary_path
      end
    else
      render "new"
    end
  end

  private 

  def message_params
    params.require(:message).permit(:content, :pack_name, :page_number, :question_number, :subject_name)
  end

end
class AdminMailer < ApplicationMailer
  default :to => "tjterminator.dev@gmail.com"

  def student_enquiry(user, message)
    @user = user
    full_message = user.full_name + "(" + user.id.to_s + ") needs help with " + message.subject_name + ". In particular pack " + message.pack_name + " on page " + message.page_number + ", question number " + message.question_number + ". The following additional details have been given: " + message.content
    if @user.role == 'student'
      mail(from: @user.email, subject: "Help Required", body: full_message)
    end
  end

  def registration_confirmation_to_admin(user)
    @user = user
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: "A new Registration")
  end


end

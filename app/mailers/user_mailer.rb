class UserMailer < ApplicationMailer
  default from: "tjterminator.dev@gmail.com"

  def registration_confirmation_to_user(child)
    @user = user
    if @user.role == 'student'
      mail(:to => @user.parent.email, :subject => "Registration Complete for OurCompany")
    else 
      mail(:to => @user.email, :subject => "Registration Complete for OurCompany")
    end
  end

  def suspension_email(student)
    @student = student
    mail(:to => @student.parent.email, :subject => "Suspension of MyCompany Account")
  end

  def cancel_child_account(student, message)
    @student = student
    @message = message
    mail(:to => @student.parent.email, :subject => @message.message_subject)
  end

  def new_work_email(student, pack)
    @student = student
    @pack = pack
    mail(:to => @student.parent.email, :subject => "New work added to MyCompany Account")
  end

  def reward_expiry_reminder(student)
    @student = student
    mail(:to => @student.parent.email, :subject => "Rewards expiring in 1 month")
  end

  def work_missing(student, pack_record)
    @student = student
    @pack_record = pack_record
    mail(:to => @student.parent.email, :subject => "Work missing for OurCompany")
  end

  def missing_payment(student)
    @student = student
    mail(:to => @student.parent.email, :subject => "Payment Missing for OurCompany")
  end

  def send_email_to_user(message)
    @message = message
    mail(:to => @message.message_recipient, :subject => @message.subject)
  end

  def send_enrolment_deletion(student)
    @student = student
    mail(:to => @student.parent.email, :subject => "Confirmation of Enrolment Deletion")
  end

  def recommend_us(parent, message)
    @parent = parent
    @message = message
    mail(:to => @message.message_recipient, :subject => "Recommendation of Our Company")
  end

  def new_enrolment(student, enrolment)
    @student = student
    @enrolment = enrolment
    mail(:to => @student.parent.email, :subject => "New Enrolment")
  end

end

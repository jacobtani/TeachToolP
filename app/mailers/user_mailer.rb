class UserMailer < ApplicationMailer
  default from: "tjterminator.dev@gmail.com"

  def registration_confirmation_to_user(user)
    @user = user
    if @user.role == 'student'
      mail(:to => @user.parent.email, :subject => "Registration Complete for OurCompany")
    else 
      mail(:to => @user.email, :subject => "Registration Complete for OurCompany")
    end
  end

  def suspension_email(user)
    @user = user
    mail(:to => @user.parent.email, :subject => "Suspension of MyCompany Account")
  end

  def cancellation_email(user, message)
    @user = user
    full_message = 'The user account was cancelled because ' + message.content
    mail(:to => @user.email, :subject => message.message_subject, body: full_message)
  end

  def new_work_email(user, pack)
    @user = user
    @pack = pack
    mail(:to => @user.parent.email, :subject => "New work added to MyCompany Account")
  end

  def reward_expiry_reminder(user)
    @user = user
    mail(:to => @user.parent.email, :subject => "Rewards expiring in 1 month")
  end

  def work_missing(user, pack_record)
    @user = user
    @pack_record = pack_record
    mail(:to => @user.parent.email, :subject => "Work missing for OurCompany")
  end

  def missing_payment(user)
    @user = user
    mail(:to => @user.parent.email, :subject => "Payment Missing for OurCompany")
  end

  def send_email_to_user(message)
    @message = message
    mail(:to => message.message_recipient, :subject => message.subject)
  end

  def send_enrolment_deletion(user)
    @user = user
    mail(:to => @user.parent.email, :subject => "Confirmation of Enrolment Deletion")
  end

  def recommend_us(user, message)
    mail(:to => message.message_recipient, :subject => "Recommendation of Our Company")
  end

  def new_enrolment(user, enrolment)
    @user = user
    @enrolment = enrolment
    mail(:to => @user.parent.email, :subject => "New Enrolment")
  end

end

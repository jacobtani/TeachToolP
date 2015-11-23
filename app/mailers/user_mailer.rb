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

  def cancellation_email(user)
    @user = user
    mail(:to => @user.parent.email, :subject => "Cancellation of MyCompany Account")
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

end

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

end

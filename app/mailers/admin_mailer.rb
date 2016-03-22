class AdminMailer < ApplicationMailer
  default :to => "tjterminator.dev@gmail.com"

  def student_cancelled_acount(user, message)
    @user = user
    @message = message
    mail(from: => @user.email, :subject => @message.message_subject)
  end

  def student_enquiry(user, message)
    @user = user
    @message = message
    if @user.role == 'student'
      mail(from: @user.email, subject: @message.subject)
    end
  end

  def parent_help_required(user, message)
    @user = user
    @message = message
    if @user.role == 'parent'
      mail(from: @user.email, subject: @message.subject)
    end
  end

  def registration_confirmation_to_admin(user)
    @user = user
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: "ADDING NEW USER")
  end

  def missing_pack(user, message)
    @user = user
    @message = message
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: @message.subject)
  end

  def payment_related_enquiry(user, message)
    @user = user
    @message = message
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: @message.subject)
  end

  def general_parent_enquiry(user, message)
    @user = user
    @message = message
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: @message.subject)
  end

  def redeem_reward(user, amount)
    @user = user
    @amount = amount
    mail(from: @user.parent.email, to: 'tjterminator.dev@gmail.com', subject: 'REWARD REDEMPTION')
  end

  def new_enrolment(user, enrolment)
    @user = user
    @enrolment = enrolment
    mail(:to => @user.parent.email, :subject => "NEW ENROLMENT")
  end

  def reminder_nullify_rewards
    mail(:to => 'tjterminator.dev@gmail.com', from: 'tanzjacob@gmail.com', subject: 'Please nullify rewards')
  end


end
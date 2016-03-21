class AdminMailer < ApplicationMailer
  default :to => "tjterminator.dev@gmail.com"

  def student_enquiry(user, message)
    @user = user
    full_message = user.full_name + "(" + user.id.to_s + ") needs help with " + message.subject_name + ". In particular pack " + message.pack_name + " on page " + message.page_number + ", question number " + message.question_number + ". The following additional details have been given: " + message.content
    if @user.role == 'student'
      mail(from: @user.email, subject: message.subject, body: full_message)
    end
  end

  def parent_help_required(user, message)
    @user = user
    full_message = user.full_name + "(" + user.id.to_s + ") needs help with " + message.subject_name + ". In particular pack " + message.pack_name + " on page " + message.page_number + ", question number " + message.question_number + ". The following additional details have been given: " + message.content
    if @user.role == 'parent'
      mail(from: @user.email, subject: message.subject, body: full_message)
    end
  end

  def registration_confirmation_to_admin(user)
    @user = user
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: "ADDING NEW USER")
  end

  def missing_pack(user, message)
    @user = user
    full_message = user.full_name + ' wants to report a pack missing: ' + message.pack_name + ' with the following details: ' + message.content
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: message.subject, body: full_message)
  end

  def payment_related_enquiry(user, message)
    @user = user
    full_message = @user.full_name + ' has the following payment related enquiry: ' + message.content
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: message.subject, body: full_message)
  end

  def general_parent_enquiry(user, message)
    @user = user
    full_message = @user.full_name + ' has the following general question: ' + message.content
    mail(from: @user.email, to: 'tjterminator.dev@gmail.com', subject: 'GENERAL CORRESPONDENCE', body: full_message)
  end

  def redeem_reward(user, amount)
    @user = user
    full_message = @user.parent.full_name + ' would like to redeem their rewards for ' + user.full_name + ' of $' + amount.to_s
    mail(from: @user.parent.email, to: 'tjterminator.dev@gmail.com', subject: 'REWARD REDEMPTION', body: full_message)
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
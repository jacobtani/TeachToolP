class AdminMailer < ApplicationMailer
  default :to => "tjterminator.dev@gmail.com"

  def student_needs_help(student, message)
    @student = student
    @message = message
    if @student.role == 'student'
      mail(from: @student.email, subject: @message.subject)
    end
  end

  def parent_needs_help(parent, student, message)
    @parent = parent
    @student = student
    @message = message
    if @parent.role == 'parent'
      mail(from: @parent.email, subject: @message.subject)
    end
  end

  def missing_pack(parent, student, message)
    @parent = parent
    @student = student
    @message = message
    mail(from: @parent.email, to: 'tjterminator.dev@gmail.com', subject: @message.subject)
  end

  def payment_related_enquiry(parent, student, message)
    @parent = parent
    @student = student
    @message = message
    mail(from: @parent.email, to: 'tjterminator.dev@gmail.com', subject: @message.subject)
  end

  def general_parent_enquiry(parent, message)
    @parent = parent
    @message = message
    mail(from: @parent.email, to: 'tjterminator.dev@gmail.com', subject: @message.subject)
  end

  def student_cancelled_account(student, message)
    @student = student
    @message = message
    mail(from: @student.email, subject: @message.message_subject)
  end

  def registration_confirmation_to_admin(student)
    @student = student
    mail(from: @student.parent.email, to: 'tjterminator.dev@gmail.com', subject: "ADDING NEW USER")
  end

  def redeem_reward(student, amount)
    @student = student
    @amount = amount
    mail(from: @student.parent.email, to: 'tjterminator.dev@gmail.com', subject: 'REWARD REDEMPTION')
  end

  def reminder_nullify_rewards
    mail(to: 'tjterminator.dev@gmail.com', from: 'tanzjacob@gmail.com', subject: 'NULLIFY REWARDS TIME')
  end


end
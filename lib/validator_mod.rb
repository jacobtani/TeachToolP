module ValidatorMod
  extend self

  def validate_rewards(user)
    if Date.today == user.activation_date + 6.months
      user.rewards = 0.00
      user.activation_date = Date.today
      user.save 
    elsif user.activation_date + 5.months == Date.today
      UserMailer.reward_expiry_reminder(user).deliver_now
    end 
  end

  def nullify_rewards
    students = User.students 
    students.each do |student|
      student.update(rewards: 0)
    end
  end  

end
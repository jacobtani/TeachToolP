module ValidatorMod
  extend self

  def nullify_rewards
    students = User.students 
    students.each do |student|
      student.update(rewards: 0)
    end
  end  

end
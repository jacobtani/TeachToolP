module CalculationMod
  extend self

  def calculate_total_fees (user)
    binding.pry
    total_fees = 0
    subject_enrolment_fees = calculate_subject_enrolment_fees(user)
    user.total_fees = subject_enrolment_fees
    user.account_balance = user.total_fees
    user.save
    subject_enrolment_fees
  end

  def calculate_subject_enrolment_fees(user)
    subject_enrolment_fees = 0
    if user.role == 'student' && user.enrolments.present?
      user.enrolments.each do |enrolment| 
        subject_enrolment_fees+= enrolment.fees
      end
    end
    subject_enrolment_fees
  end

end
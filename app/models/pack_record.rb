class PackRecord < ActiveRecord::Base
  belongs_to :user

  def calculate_reward(user, score, pack_record)
    if score >= 70 && score <= 79
        pack_record.reward = 0.50
    elsif score >= 80 && score  <= 89
        pack_record.reward = 1.00
    elsif score >= 90 && score <= 100
        pack_record.reward = 2.00
    end
    #pack_record.save
  end

end
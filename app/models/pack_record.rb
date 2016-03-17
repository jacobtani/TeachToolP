class PackRecord < ActiveRecord::Base
  belongs_to :user
  enum status: [:DISPATCHED, :RECEIVED, :COMPLETED]
  scope :overdue, -> { where("due_date < ?", Date.today ) }
  store_accessor :comments, :speed, :accuracy, :completion, :presentation

  def calculate_reward(user, score, pack_record)
    if score >= 70 && score <= 79
      reward = 0.50
    elsif score >= 80 && score <= 89
      reward = 1.00
    elsif score >= 90 && score <= 100
      reward = 1.50
    else
      reward = 0.00
    end
    reward
  end

end
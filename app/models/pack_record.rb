class PackRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :pack
  enum status: [:DISPATCHED, :RECEIVED, :COMPLETED]
  scope :overdue, -> { where("due_date < ?", Date.today ) }
  validates :due_date, date: { after: :start_date }
  validates_presence_of :start_date, :due_date, :user_id, :pack_id,  :status

  #Calculate the reward a user gets for a pack record based on their score
  def self.calculate_reward(score)
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

  #Calculate score for a pack record based on the different metrics
  def self.calculate_score(pack_record)
    accuracy = pack_record.accuracy
    completion = pack_record.completion
    quality = pack_record.quality
    presentation = pack_record.presentation
    consistency = pack_record.consistency
    score = (0.4 *accuracy + 0.25* completion + 0.15* quality + 0.10*presentation + 0.10*consistency)
    score
  end

  #Determine the posting number for the pack record that's been created
  def self.compute_posting_number(user)
    posting_number = user.pack_records.present? ? user.pack_records.last.posting_number + 1 : 1
  end

end
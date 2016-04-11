class Enrolment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  scope :recent, -> { where("created_at > ?", Time.now - 3.minutes ) }
  validates_uniqueness_of :user_id, scope: :subject_id, message: "can only enrol once per subject"
  validate :validate_enrolment #ensure enrolment subject is same as offer applied for subject
  validates_presence_of :subject_id, :date, :fees, :ability_level, :grade

  def self.validate_offer(user, enrolment)
    enrolment_fee = user.enrolments.count > 1 ? 0 : Fee.all.where(fee_type: 0).first.amount
    monthly_fee = Fee.all.where(subject_id: enrolment.subject_id, fee_type: 1).first.amount
    unless enrolment.offer_id.nil?
      @offer = Offer.find(enrolment.offer_id)
      new_enrolment_fee = self.apply_enrolment_fee_adjustments(enrolment_fee, @offer.discount_enrolment, @offer.percentage_enrolment)
      new_monthly_fee = self.apply_monthly_fee_adjustments(monthly_fee, @offer.discount_monthly, @offer.percentage_monthly)
      self.calculate_total_enrolment_fees(user, new_enrolment_fee, new_monthly_fee, enrolment)
    else
      self.calculate_total_enrolment_fees(user, enrolment_fee, monthly_fee, enrolment)
    end
  end

  #Check enrolment's subject id is the same as that of the offer being used for the enrolment
  def validate_enrolment
    if self.offer_id.present?
      if self.subject_id != Offer.find(self.offer_id).subject_id
        errors.add(:enrolment, 'Offer subject id not same as enrolment subject')
      end
    end
  end

  #Calculate enrolment fee based on offer discounts
  def self.apply_enrolment_fee_adjustments(enrolment_fee, discount_amount, percentage)
    if discount_amount.present?
      enrolment_fee = enrolment_fee - discount_amount
    elsif percentage.present?
      enrolment_fee = enrolment_fee - (enrolment_fee * percentage/100)
    end
    enrolment_fee
  end

  #Calculate monthly fee based on discount
  def self.apply_monthly_fee_adjustments(monthly_fee, discount_amount, percentage)
    if discount_amount.present?
      monthly_fee = monthly_fee - discount_amount
    elsif percentage.present?
      monthly_fee = monthly_fee - (monthly_fee * percentage/100)
    end
    monthly_fee
  end

  #Calculate total enrolment fees
  def self.calculate_total_enrolment_fees (user, enrolment_fee, monthly_fee, enrolment)
    enrolment.update(monthly_fee: monthly_fee)
    user.update(enrolment_fee: enrolment_fee)
    total_fees = monthly_fee + enrolment_fee
    user.account_balance += total_fees
    user.save
  end

end
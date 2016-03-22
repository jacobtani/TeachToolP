class Enrolment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :subject_id, message: "can only enrol once per subject"
  validate :validate_enrolment #ensure enrolment subject is same as offer applied for subject
  
  def self.validate_offer(user, enrolment)
    @offer = Offer.find(enrolment.offer_id) if enrolment.offer_id
    if @offer
      enrolment_fee = Fee.all.where(fee_type: 1).first.amount
      monthly_fee = Fee.all.where(subject_id: enrolment.subject_id, fee_type: 0).first.amount
      if user.enrolments.present?
        new_enrolment_fee = 0
      else
        new_enrolment_fee = self.apply_enrolment_fee_adjustments(enrolment_fee, @offer.discount_enrolment, @offer.percentage_enrolment)
      end
      new_monthly_fee = self.apply_monthly_fee_adjustments(monthly_fee, @offer.discount_monthly, @offer.percentage_monthly)
      self.calculate_enrolment_fees(new_enrolment_fee, new_monthly_fee, enrolment)
    else
      self.calculate_enrolment_fees(enrolment_fee, monthly_fee, enrolment)
    end
  end

  #Check enrolment's subject id is the same as that of the offer being used for the enrolment
  def validate_enrolment
    if self.subject_id != Offer.find(self.offer_id).subject_id
      errors.add(:enrolment, 'Offer subject id not same as enrolment subject')
    end
  end

  def self.apply_enrolment_fee_adjustments(enrolment_fee, discount_amount, percentage)
    if discount_amount.present?
      enrolment_fee = enrolment_fee - discount_amount
    elsif percentage.present?
      enrolment_fee = enrolment_fee * percentage/100
    end
    enrolment_fee
  end

  def self.apply_monthly_fee_adjustments(monthly_fee, discount_amount, percentage)
    if discount_amount.present?
      monthly_fee = monthly_fee - discount_amount
    elsif percentage.present?
      monthly_fee = monthly_fee * percentage/100
    end
    monthly_fee
  end

  def self.calculate_enrolment_fees (enrolment_fee, monthly_fee, enrolment)
    if enrolment.fees == 0 
      enrolment.fees = enrolment_fee + monthly_fee
      enrolment.save
    end
  end

end
class Enrolment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :subject_id, message: "can only enrol once per subject"
  validate :validate_offer 
  
  def validate_offer
    @offer = Offer.find(self.offer_id) if self.offer_id
    if @offer
      enrolment_fee = Fee.all.where(fee_type: 1).first.amount
      monthly_fee = Fee.all.where(subject_id: self.subject_id, fee_type: 0).first.amount

      if user.enrolments.present?
        new_enrolment_fee = 0
      else
        new_enrolment_fee = apply_enrolment_fee_adjustments(enrolment_fee, @offer.discount_enrolment, @offer.percentage_enrolment)
      end
      new_monthly_fee = apply_monthly_fee_adjustments(monthly_fee, @offer.discount_monthly, @offer.percentage_monthly)
      calculate_enrolment_fees(new_enrolment_fee, new_monthly_fee)
    else
      calculate_enrolment_fees(enrolment_fee, monthly_fee)
    end
  end

  def apply_enrolment_fee_adjustments(enrolment_fee, discount_amount, percentage)
    if discount_amount.present?
      enrolment_fee = enrolment_fee - discount_amount
    elsif percentage.present?
      enrolment_fee = enrolment_fee * percentage/100
    end
    enrolment_fee
  end

  def apply_monthly_fee_adjustments(monthly_fee, discount_amount, percentage)
    if discount_amount.present?
      monthly_fee = monthly_fee - discount_amount
    elsif percentage.present?
      monthly_fee = monthly_fee * percentage/100
    end
    monthly_fee
  end

  def calculate_enrolment_fees (enrolment_fee, monthly_fee)
    if self.fees == 0 
      self.fees = enrolment_fee + monthly_fee
    end
  end


end
class Offer < ActiveRecord::Base 
  validates   :offer_name, :start_date, :end_date, presence: true
  scope :active, -> { where("start_date <= :now AND end_date >= :now ", { now: DateTime.now } ) }
end
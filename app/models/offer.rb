class Offer < ActiveRecord::Base 
  belongs_to :subject
  scope :active, -> { where("start_date <= :now AND end_date >= :now ", { now: DateTime.now } ) }
  validates_presence_of :offer_name, :start_date, :end_date
  validates :end_date, date: { after: :start_date }
end
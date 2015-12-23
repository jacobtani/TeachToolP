class Offer < ActiveRecord::Base 
  validates   :offer_name, :start_date, :end_date, presence: true
end
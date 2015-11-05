class Offer < ActiveRecord::Base 
  validates   :offer_name, :start_date, :end_date, :includes_free_trial, presence: true
end
class Fee < ActiveRecord::Base
  belongs_to :subject
  enum fee_type: [:ENROLMENT, :MONTHLY, :DEFERMENT, :CONTINGENCY]
  validates_presence_of :fee_name, :amount, :start_date, :end_date
  validates :end_date, date: { after: :start_date }
end
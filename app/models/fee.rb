class Fee < ActiveRecord::Base
  enum fee_type: [:ENROLMENT, :MONTHLY, :DEFERMENT, :CONTINGENCY]
  belongs_to :subject
end
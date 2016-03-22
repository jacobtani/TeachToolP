class Fee < ActiveRecord::Base
  enum fee_type: [:ENROLMENT, :MONTHLY, :DEFERMENT, :CONTINGENCY]
end
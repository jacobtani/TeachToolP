class Enrolment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :subject_id, message: "can only enrol once per subject"
end
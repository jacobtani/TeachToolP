class Enrolment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  validates :subject_id, uniqueness: {scope: :user_id}
end
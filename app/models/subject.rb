class Subject < ActiveRecord::Base
  has_many :packs, dependent: :destroy, inverse_of: :subject
  has_one :fee
  has_many :offers, dependent: :destroy
  validates_presence_of :subject_name, :fee_id, :lowest_grade_taught, :highest_grade_taught
end
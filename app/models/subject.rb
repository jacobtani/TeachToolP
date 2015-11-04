class Subject < ActiveRecord::Base
  has_many :packs, dependent: :destroy, inverse_of: :subject
  has_many :ribbons, through: :packs, dependent: :destroy
#  has_many :grades
  validates  :subject_name, presence: true
end
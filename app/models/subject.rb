class Subject < ActiveRecord::Base
  has_many :packs, dependent: :destroy, inverse_of: :subject
  validates :subject_name, presence: true
end
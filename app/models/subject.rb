class Subject < ActiveRecord::Base
  has_many :packs, dependent: :destroy, inverse_of: :subject
  validates :subject_name, presence: true
  has_one :fee
  has_many :offers, dependent: :destroy
end
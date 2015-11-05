class Ribbon < ActiveRecord::Base
  belongs_to :subject, inverse_of: :ribbons
  has_many :packs, dependent: :destroy
  validates :name, :address, presence: true
end
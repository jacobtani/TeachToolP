class Ribbon < ActiveRecord::Base
  belongs_to :subject, inverse_of: :ribbons
  has_many :packs, dependent: :destroy
  validates :name, :address, presence: true
  validate :validate_packs

  def validate_packs
    errors.add(:packs, "not enough packs in the ribbon") if packs.size < 52 
  end
end
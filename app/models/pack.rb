class Pack < ActiveRecord::Base
  belongs_to :subject, inverse_of: :packs
  has_many :enclosures, dependent: :destroy
  validates :name, :description, presence: true
  enum pack_type: [:NORMAL, :GLOBAL, :HIGH_INTENSITY]
end
class Ribbon < ActiveRecord::Base
  belongs_to :subject
  has_many :packs, dependent: :destroy
  validates   :name, :address, presence: true
end
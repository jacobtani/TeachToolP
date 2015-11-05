class Pack < ActiveRecord::Base
  belongs_to :subject, inverse_of: :packs
  #has_many :users
  has_many :enclosures, dependent: :destroy
  validates :name, :description, presence: true

end
class Pack < ActiveRecord::Base
  belongs_to :subject
  #has_many :users
  has_many :enclosures, dependent: :destroy
  validates :name, presence: true

end
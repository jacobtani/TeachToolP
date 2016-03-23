class Pack < ActiveRecord::Base
  belongs_to :subject, inverse_of: :packs
  has_many :enclosures, dependent: :destroy
  validates :name, :description, presence: true
  enum pack_type: [:NORMAL, :GLOBAL, :HIGH_INTENSITY]

  #Update the stock of unassigned vs assigned of a pack
  def self.update_stock(pack)
    pack.update(number_unassigned: (pack.number_unassigned -1), number_assigned: (number_assigned + 1))
  end

end
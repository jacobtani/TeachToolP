class Pack < ActiveRecord::Base
  belongs_to :subject, inverse_of: :packs
  has_many :enclosures, dependent: :destroy
  validates :name, :description, presence: true
  enum pack_type: [:NORMAL, :GLOBAL, :HIGH_INTENSITY]

  def self.update_stock(pack)
    pack.number_unassigned = pack.number_unassigned - 1
    pack.number_assigned += 1
    pack.save
  end

end
class Pack < ActiveRecord::Base
  belongs_to :subject, inverse_of: :packs
  has_many :enclosures, dependent: :destroy
  has_many :pack_records, dependent: :destroy
  enum pack_type: [:NORMAL, :GLOBAL, :HIGH_INTENSITY]
  validates_presence_of :name, :description, :subject_id, :number_unassigned, :pack_type, :priority
  
  #Update the stock of unassigned vs assigned of a pack  
  def self.update_stock(pack)
    number_unassigned = pack.number_unassigned - 1
    number_assigned = pack.number_assigned + 1
    pack.update(number_assigned: number_assigned, number_unassigned: number_unassigned)
  end

end
class Enclosure < ActiveRecord::Base
  belongs_to :pack
  enum enclosure_type: [:FREE, :RETURNABLE]
  enum status: [:AVAILABLE, :UNAVAILABLE]
  validates_presence_of :name, :barcode, :status, :due_date, :enclosure_type, :pack_id
end
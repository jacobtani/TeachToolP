class Enclosure < ActiveRecord::Base
  #belongs_to :pack
  enum enclosure_type: [:FREE, :RETURNABLE]
end
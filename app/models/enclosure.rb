class Enclosure < ActiveRecord::Base
  #belongs_to :pack
  enum enclosure_type: [:BOOK]
end
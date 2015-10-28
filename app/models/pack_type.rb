class PackType < ActiveRecord::Base
  enum type: [:normal, :global, :high_intensity]

end
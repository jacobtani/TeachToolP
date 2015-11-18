class AddEnclosuretypeEnclosures < ActiveRecord::Migration
  def change
    add_column :enclosures, :enclosure_type, :integer, default: 0
  end
end

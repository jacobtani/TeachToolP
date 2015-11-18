class DropEnclosuretypes < ActiveRecord::Migration
  def change
    drop_table :enclosure_types
  end
end

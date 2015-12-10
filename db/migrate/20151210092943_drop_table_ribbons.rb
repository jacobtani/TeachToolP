class DropTableRibbons < ActiveRecord::Migration
  def change
    drop_table :ribbons
    remove_reference :users, :ribbon
  end
end

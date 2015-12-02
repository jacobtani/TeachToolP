class AddPackidrefEnclosures < ActiveRecord::Migration
  def change
    add_reference :enclosures, :pack, null:false, index: true
  end
end

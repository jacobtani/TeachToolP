class AddPriorityPack < ActiveRecord::Migration
  def change
    add_column :packs, :priority, :integer, default: 1
  end
end

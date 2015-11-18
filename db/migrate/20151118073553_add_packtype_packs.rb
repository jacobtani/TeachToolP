class AddPacktypePacks < ActiveRecord::Migration
  def change
    add_column :packs, :pack_type, :integer, default: 0
  end
end

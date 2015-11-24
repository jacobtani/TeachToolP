class AddStockcontrolPacks < ActiveRecord::Migration
  def change
    remove_column :packs, :in_stock?, :boolean
    add_column :packs, :number_unassigned, :integer, default: 0
    add_column :packs, :number_assigned, :integer, default: 0
  end
end

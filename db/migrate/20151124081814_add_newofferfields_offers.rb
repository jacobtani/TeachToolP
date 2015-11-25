class AddNewofferfieldsOffers < ActiveRecord::Migration
  def change
    add_column :offers, :discount_amount, :float, default: 0
    add_column :offers, :percentage_discount, :integer, default: 0
    add_column :offers, :number_of_subjects, :integer, default: 0
  end
end

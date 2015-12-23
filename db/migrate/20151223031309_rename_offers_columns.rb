class RenameOffersColumns < ActiveRecord::Migration
  def change
    remove_column :offers, :discount_amount, :float
    remove_column :offers, :percentage_discount, :integer
    add_column :offers, :discount_monthly, :float
    add_column :offers, :discount_enrolment, :integer
    add_column :offers, :percentage_monthly, :integer
    add_column :offers, :percentage_enrolment, :integer
  end
end

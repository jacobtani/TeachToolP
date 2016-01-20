class AddAccountbalanceUser < ActiveRecord::Migration
  def change
    add_column :users, :account_balance, :float
  end
end

class TidyUsers < ActiveRecord::Migration
  def change
    remove_column :users, :account_balance
    add_column :users, :account_balance, :float, default: 0
    remove_column :users, :mailing_address
    remove_column :users, :contact_mobile
  end
end

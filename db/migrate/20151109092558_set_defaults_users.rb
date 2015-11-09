class SetDefaultsUsers < ActiveRecord::Migration
  def change
    change_column :users, :overdue_fees, :float, default: 0.00
    change_column :users, :coupon_value, :float, default: 0.00
  end
end

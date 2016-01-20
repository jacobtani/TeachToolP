class AddPaymentdateUsers < ActiveRecord::Migration
  def change
    add_column :users, :payment_due, :datetime, default: Date.today
  end
end

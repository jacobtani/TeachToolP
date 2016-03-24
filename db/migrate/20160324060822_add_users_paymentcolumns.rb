class AddUsersPaymentcolumns < ActiveRecord::Migration
  def change
    add_column :users, :last_payment_date, :datetime
  end
end

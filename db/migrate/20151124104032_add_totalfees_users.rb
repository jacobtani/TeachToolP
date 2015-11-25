class AddTotalfeesUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_fees, :float, default: 0
  end
end

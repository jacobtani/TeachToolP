class AddRewardactivationdateUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_date, :datetime
    add_column :users, :rewards, :float, default: 0.00
  end
end

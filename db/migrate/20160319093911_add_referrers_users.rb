class AddReferrersUsers < ActiveRecord::Migration
  def change
    add_column :users, :referrer_count, :integer, default: 0
    add_column :users, :referrer_email, :string
  end
end

class AddAdditionalinfoUsers < ActiveRecord::Migration
  def change
    add_column :users, :additional_info, :text
  end
end

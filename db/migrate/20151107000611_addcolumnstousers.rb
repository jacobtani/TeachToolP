class Addcolumnstousers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip_code, :integer
    add_column :users, :contact_email, :string
    add_column :users, :contact_phone, :string
    add_column :users, :contact_mobile, :string
  end
end

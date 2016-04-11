class AddMorefeesEnrolments < ActiveRecord::Migration
  def change
    remove_column :enrolments, :fees
    add_column :enrolments, :monthly_fee, :float, default: 0
    add_column :users, :enrolment_fee, :float, default: 0
  end
end

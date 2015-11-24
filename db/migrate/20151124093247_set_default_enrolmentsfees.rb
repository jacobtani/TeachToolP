class SetDefaultEnrolmentsfees < ActiveRecord::Migration
  def change
    remove_column :enrolments, :fees, :float
    add_column :enrolments, :fees, :float, default: 0
  end
end

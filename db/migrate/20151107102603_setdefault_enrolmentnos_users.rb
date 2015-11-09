class SetdefaultEnrolmentnosUsers < ActiveRecord::Migration
  def change
    remove_column :users, :number_of_enrolments, :integer
    add_column :users, :number_of_enrolments, :integer, default: 0
  end
end

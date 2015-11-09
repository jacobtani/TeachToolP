class UpdateEnrolments < ActiveRecord::Migration
  def change
    remove_column :enrolments, :number_of_subjects, :integer
    add_column :enrolments, :grade, :integer, null: false 
  end
end

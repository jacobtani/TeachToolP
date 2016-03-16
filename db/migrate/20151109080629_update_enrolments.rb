class UpdateEnrolments < ActiveRecord::Migration
  def change
    add_column :enrolments, :grade, :integer, null: false 
  end
end

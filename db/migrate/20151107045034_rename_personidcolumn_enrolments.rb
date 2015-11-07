class RenamePersonidcolumnEnrolments < ActiveRecord::Migration
  def change
    remove_column :enrolments, :person_id, :integer
    add_reference :enrolments, :user, null:false, index: true
  end
end

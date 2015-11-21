class RenameAdditionalIdEnrolments < ActiveRecord::Migration
  def change
    remove_reference :enrolments, :user
    add_reference :enrolments, :user, null:false, index: true
  end
end

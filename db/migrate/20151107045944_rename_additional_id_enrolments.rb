class RenameAdditionalIdEnrolments < ActiveRecord::Migration
  def change
    remove_reference :enrolments, :user_id
    add_reference :enrolments, :user, null:false, index: true
  end
end

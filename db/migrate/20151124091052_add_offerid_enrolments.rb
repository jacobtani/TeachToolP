class AddOfferidEnrolments < ActiveRecord::Migration
  def change
    add_reference :enrolments, :offer, index: true  
  end
end

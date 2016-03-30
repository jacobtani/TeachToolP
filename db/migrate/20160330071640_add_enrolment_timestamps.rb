class AddEnrolmentTimestamps < ActiveRecord::Migration
  def change
    add_column :enrolments, :created_at, :datetime
    add_column :enrolments, :updated_at, :datetime
  end
end

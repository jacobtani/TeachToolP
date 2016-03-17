class AddRatingEnrolments < ActiveRecord::Migration
  def change
    add_column :enrolments, :ability_level, :integer, default: 0
  end
end

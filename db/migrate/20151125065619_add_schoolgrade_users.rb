class AddSchoolgradeUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_grade, :integer, default: 1
  end
end

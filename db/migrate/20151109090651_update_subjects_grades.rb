class UpdateSubjectsGrades < ActiveRecord::Migration
  def change
    remove_column :subjects, :grades, :array
    add_column :subjects, :lowest_grade_taught, :integer
    add_column :subjects, :highest_grade_taught, :integer
  end
end

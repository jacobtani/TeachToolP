class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string    :subject_name
      t.float     :fee
      t.text :grades, array: true, default: []
    end
  end
end

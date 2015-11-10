class RenameGradePackrecords < ActiveRecord::Migration
  def change
    remove_column :pack_records, :grade, :string
    add_column :pack_records, :score, :integer, default: 0, max: 200
  end
end

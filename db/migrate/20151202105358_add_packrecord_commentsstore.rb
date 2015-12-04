class AddPackrecordCommentsstore < ActiveRecord::Migration
  def change
    add_column :pack_records, :comments, :hstore
  end
end

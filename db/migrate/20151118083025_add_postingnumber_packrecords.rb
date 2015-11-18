class AddPostingnumberPackrecords < ActiveRecord::Migration
  def change
    add_column :pack_records, :posting_number, :integer, default: 0
  end
end

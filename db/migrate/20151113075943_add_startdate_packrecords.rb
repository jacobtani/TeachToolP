class AddStartdatePackrecords < ActiveRecord::Migration
  def change
  	add_column :pack_records, :start_date, :datetime
  end
end

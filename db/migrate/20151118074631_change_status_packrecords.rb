class ChangeStatusPackrecords < ActiveRecord::Migration
  def change
    remove_column :pack_records, :status, :string
    add_column :pack_records, :status, :integer, default: 0
  end
end

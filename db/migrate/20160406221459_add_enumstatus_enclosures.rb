class AddEnumstatusEnclosures < ActiveRecord::Migration
  def change
    remove_column :enclosures, :status
    add_column :enclosures, :status, :integer
  end
end

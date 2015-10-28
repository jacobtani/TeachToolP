class CreateEnclosureTypes < ActiveRecord::Migration
  def change
    create_table :enclosure_types do |t|
      t.integer :type
    end
  end
end

class CreateEnclosures < ActiveRecord::Migration
  def change
    create_table :enclosures do |t|
      t.string    :name
      t.integer   :barcode
      t.boolean   :returnable?
      t.string    :status
      t.datetime  :due_date
    end
  end
end

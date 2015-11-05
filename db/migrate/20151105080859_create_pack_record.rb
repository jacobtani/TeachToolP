class CreatePackRecord < ActiveRecord::Migration
  def change
    create_table :pack_records do |t|
      t.datetime :record_date
      t.string   :grade
      t.string   :comment
      t.string   :status
      t.datetime :due_date
      t.references :pack, null: false, index: true
      t.references  :user, null: false, index: true
      t.timestamps  null: false
    end
  end
end

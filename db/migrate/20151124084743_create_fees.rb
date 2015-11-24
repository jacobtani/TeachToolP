class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.float :amount
      t.integer :fee_type, default: 0
      t.references  :subject, index: true
      t.timestamps  null: false      
    end
  end
end
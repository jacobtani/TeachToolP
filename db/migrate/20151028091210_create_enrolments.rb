class CreateEnrolments < ActiveRecord::Migration
  def change
    create_table :enrolments do |t|
      t.references :person, null: false, index: true
      t.datetime  :date
      t.references  :subject, null: false, index: true
      t.datetime  :activation_date
      t.float     :fees
      t.boolean   :deferred?
      t.datetime  :start_date
    end
  end
end

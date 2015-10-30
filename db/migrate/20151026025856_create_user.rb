class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :first_name, null: false
      t.string      :surname, null: false
      t.datetime    :date_of_birth
      t.string      :role, null: false
      t.string      :username
      t.string      :password
      t.string      :phone_number
      t.text        :mailing_address
      t.text        :postal_address, null: false
      t.integer     :number_of_enrolments
      t.float       :overdue_fees
      t.float       :coupon_value
      t.timestamps  null: false
    end
  end
end

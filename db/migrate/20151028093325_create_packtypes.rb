class CreatePacktypes < ActiveRecord::Migration
  def change
    create_table :packtypes do |t|
      t.integer :type
    end
  end
end

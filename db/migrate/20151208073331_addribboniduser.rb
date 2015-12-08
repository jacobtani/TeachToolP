class Addribboniduser < ActiveRecord::Migration
  def change
    add_reference :users, :ribbon, index: true
  end
end

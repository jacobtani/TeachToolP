class RemoveNoenrolmentstotalfeesUsers < ActiveRecord::Migration
  def change
    remove_column :users, :number_of_enrolments, :integer
  end
end

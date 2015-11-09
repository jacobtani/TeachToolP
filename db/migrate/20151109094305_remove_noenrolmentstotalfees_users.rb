class RemoveNoenrolmentstotalfeesUsers < ActiveRecord::Migration
  def change
    remove_column :users, :number_of_enrolments, :integer
    remove_column :users, :total_fees, :float
  end
end

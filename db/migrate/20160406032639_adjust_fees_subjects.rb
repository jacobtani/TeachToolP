class AdjustFeesSubjects < ActiveRecord::Migration
  def change
    remove_column :subjects, :fee
    add_reference :subjects, :fee, null:true, index: true 
    add_column :fees, :fee_name, :string     
  end
end
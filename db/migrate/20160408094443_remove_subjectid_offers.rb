class RemoveSubjectidOffers < ActiveRecord::Migration
  def change
    remove_reference :offers, :subject
    add_reference :offers, :subject, null:true, index: true
  end
end

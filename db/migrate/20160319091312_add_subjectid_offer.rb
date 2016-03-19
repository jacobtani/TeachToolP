class AddSubjectidOffer < ActiveRecord::Migration
  def change
    add_reference :offers, :subject, null:false, index: true
  end
end

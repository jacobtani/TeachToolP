class RemoveOffersFreetrial < ActiveRecord::Migration
  def change
    remove_column :offers, :includes_free_trial, :boolean
  end
end

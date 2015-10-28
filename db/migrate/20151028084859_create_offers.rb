class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string     :offer_name
      t.text       :offer_description
      t.datetime   :start_date
      t.datetime   :end_date
      t.boolean    :includes_free_trial     
    end
  end
end

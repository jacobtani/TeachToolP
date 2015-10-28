class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :name
      t.text   :description
      t.text   :action_required
      t.references :subject, null: false, index: true
      t.boolean :in_stock?
    end
  end
end

class CreateRibbons < ActiveRecord::Migration
  def change
    create_table :ribbons do |t|
      t.string     :name
      t.references :subject, null: false, index: true
    end
  end
end

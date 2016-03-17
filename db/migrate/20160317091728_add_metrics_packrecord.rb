class AddMetricsPackrecord < ActiveRecord::Migration
  def change
  	add_column :pack_records, :accuracy, :integer, default: 0
  	add_column :pack_records, :completion, :integer, default: 0
  	add_column :pack_records, :quality, :integer, default: 0
  	add_column :pack_records, :presentation, :integer, default: 0
  	add_column :pack_records, :consistency, :integer, default: 0
  end
end

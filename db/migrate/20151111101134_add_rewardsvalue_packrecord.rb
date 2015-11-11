class AddRewardsvaluePackrecord < ActiveRecord::Migration
  def change
    add_column :pack_records, :reward, :float, default: 0.00
  end
end

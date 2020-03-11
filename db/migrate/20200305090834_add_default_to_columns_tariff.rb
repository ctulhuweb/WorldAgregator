class AddDefaultToColumnsTariff < ActiveRecord::Migration[6.0]
  def change
    change_column :tariffs, :count_sites, :integer, default: 0
    change_column :tariffs, :parse_interval, :integer, default: 0
  end
end

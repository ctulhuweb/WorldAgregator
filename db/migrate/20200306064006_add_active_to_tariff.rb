class AddActiveToTariff < ActiveRecord::Migration[6.0]
  def change
    add_column :tariffs, :active, :boolean, default: false
  end
end

class AddPriceToTariff < ActiveRecord::Migration[6.0]
  def change
    add_monetize :tariffs, :price
  end
end

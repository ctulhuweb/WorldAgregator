class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :tariff
      t.timestamps
    end
  end
end

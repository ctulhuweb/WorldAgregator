class AddPlanStripeIdToTariff < ActiveRecord::Migration[6.0]
  def change
    add_column :tariffs, :plan_stripe_id, :string 
  end
end

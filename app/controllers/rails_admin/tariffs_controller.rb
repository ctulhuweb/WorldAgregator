class RailsAdmin::TariffsController < ApplicationController
  before_action :set_tariff, only: [:add, :delete, :update]

  def add
    plan = Stripe::Plan.create({
      amount: @tariff.price.cents,
      currency: @tariff.price.currency.iso_code,
      interval: 'month',
      product: { name: @tariff.title, type: 'service' },
    })
    if @tariff.update_attribute('plan_stripe_id', plan.id)
      respond_to do |format|
        format.json {
          render json: { message: "Plan created" }, status: :ok
        } 
      end
    else
      respond_to do |format|
        format.json {
          render json: { error: "Internal error"}, status: :internal_server_error
        }
      end
    end
  end

  def delete
    plan = Stripe::Plan.delete(@tariff.plan_stripe_id)
    if plan.deleted
      respond_to do |format|
        format.js {
          render "rails_admin/main/delete_plan"
        }
      end
    end
  end

  def update
    respond_to do |format|
      format.js {
        render "rails_admin/main/update_plan"
      }
    end
  end

  private

  def set_tariff
    @tariff = Tariff.find(params[:id])
  end
end
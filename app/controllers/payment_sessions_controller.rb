require 'stripe'
class PaymentSessionsController < ApplicationController

  def checkout_session
    choosen_tariff = Tariff.find_by_title(params[:tariff_title])
    success_url = "http://#{Rails.application.config.app_config.url}/payment_sessions/success?session_id={CHECKOUT_SESSION_ID}"
    cancel_url = "http://#{Rails.application.config.app_config.url}/payment_sessions/cancel"
    byebug
    session = Stripe::Checkout::Session.create(
      customer_email: current_user.email,
      payment_method_types: ['card'],
      subscription_data: {
        items: [{
          plan: choosen_tariff.plan_stripe_id,
        }],
      },
      success_url: success_url,
      cancel_url: cancel_url,
    )
    
    Order.create(user: current_user, tariff: choosen_tariff, status: :wait, checkout_session_id: session.id)
    respond_to do |format|
      format.json {
        render json: { ch_session: session }, status: :ok
      }
    end
  end

  def success
    if params[:session_id].present?
      order = Order.where(checkout_session_id: params[:session_id]).first 
      order.update_attributes(status: :active)
    end
  end

  def cancel
    if params[:session_id].present?
      order = Order.where(checkout_session_id: params[:session_id]).first
      order.update(status: :cancel)
    end
  end
end

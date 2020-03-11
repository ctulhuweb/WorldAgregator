require 'stripe'
class PaymentSessionsController < ApplicationController

  def test
    Stripe.api_key = Rails.application.credentials.secret_key_stripe
    intent = Stripe::PaymentIntent.create({
      amount: 1099,
      currency: 'usd',
    })
    cookies[:client_secret] = intent.client_secret
    respond_to do |format|
      format.json {
        render json: { client_key: intent }, status: :ok
      }
    end
  end

  def checkout_session
    Stripe.api_key = Rails.application.credentials.secret_key_stripe
    session = Stripe::Checkout::Session.create(
      customer_email: "ctulhuweb@gmail.com",
      payment_method_types: ['card'],
      subscription_data: {
        items: [{
          plan: 'plan_GsNxbfaeGzNGgO',
        }],
      },
      success_url: 'http://da7e26c1.ngrok.io/payment_sessions/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'http://da7e26c1.ngrok.io/payment_sessions/cancel',
    )
    choosen_tariff = Tariff.find_by_title(params[:tariff_title])
    Order.create(user: current_user, tariff: choosen_tariff, status: :wait, checkout_session_id: session.id)
    respond_to do |format|
      format.json {
        render json: { ch_session: session }, status: :ok
      }
    end
  end

  def success
    order = Order.where(checkout_session_id: params[:session_id]).first
    order.update_attributes(status: :success)
  end

  def cancel
    p "ITS CANCEL"
  end

  def payment

  end
end

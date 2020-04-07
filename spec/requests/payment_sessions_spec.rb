require "rails_helper"

RSpec.describe "Payment Session Management", type: :request do
  before(:each) do
    @tariff = create(:tariff)
    @user = create(:user)
    sign_in @user
  end

  describe '#checkout_session' do
    it "create plan" do
      VCR.use_cassette("checkout_session/create_plan") do
        plan = Stripe::Plan.create({
          amount: @tariff.price_cents,
          currency: @tariff.price.currency.iso_code,
          interval: 'month',
          product: { name: @tariff.title, type: 'service' },
        })
        @tariff.update(plan_stripe_id: plan.id)
      end
      VCR.use_cassette("checkout_session/create") do
        get payment_checkout_session_path, params: { tariff_title: @tariff.title, format: :json }
      end
      p JSON.parse(reposnse.body)
      expect(reposnse).to have_http_status(:success)
    end
  end

end
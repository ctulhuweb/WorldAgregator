require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

class StripePlan < RailsAdmin::Config::Actions::Base
  register_instance_option :visible? do
    subject = bindings[:object]
    subject.is_a? Tariff
  end

  register_instance_option :member do
    true
  end

  register_instance_option :link_icon do
    'icon-chevron-up'
  end

  register_instance_option :controller do
    proc do
      @status = {}
      if @object.plan_stripe_id.present?
        begin
          plan = Stripe::Plan.retrieve(@object.plan_stripe_id)
          @status[:active] = plan.active
          @status[:id] = plan.id
        rescue => exception
          @status = { message: exception.message, type: :error }
        end
      else
        @status = { message: "This tariff not on stripe", type: :not }
      end
    end
  end
  # register_instance_option :controller do
  #   proc do
      # Stripe.api_key = Rails.application.credentials.secret_key_stripe
      # plan = Stripe::Plan.create({
      #   amount: @object.price.cents,
      #   currency: @object.price.currency.iso_code,
      #   interval: 'month',
      #   product: { name: @object.title, type: 'service' },
      # })
  #     @object.update_attributes(plan_stripe_id: plan.id)
  #     redirect_to edit_path(model_name: :tariff, id: @object.id)
  #   end
  # end
end


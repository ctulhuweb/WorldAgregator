class TariffsController < ApplicationController
  def index
    @tariffs = Tariff.active.order(:price_cents)
  end
end

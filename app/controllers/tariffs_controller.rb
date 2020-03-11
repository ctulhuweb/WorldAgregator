class TariffsController < ApplicationController
  def index
    @tariffs = Tariff.active.sort_by(&:price_cents)
  end
end

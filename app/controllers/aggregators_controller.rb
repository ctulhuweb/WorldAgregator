class AggregatorsController < ApplicationController
  def index
    @aggregators = current_user.aggregators
  end
end
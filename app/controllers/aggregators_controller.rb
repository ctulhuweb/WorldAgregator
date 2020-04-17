class AggregatorsController < ApplicationController
  def index
    @aggregators = current_user.aggregators
  end

  def new
    @aggregator = current_user.aggregators.build
  end

  def create
    @ag = current_user.aggregators.build(aggregator_params)
    respond_to do |format|
      if @ag.save
        format.js {
          redirect_to "index", notice: "Aggregator created successfuly."
        }
      else
        format.js {
          flash[:alert] = @ag.errors.full_messages.first
          flash.discard
          render partial: "shared/error", status: :unprocessable_entity
        }
      end  
    end
  end

  def edit

  end

  def update
    ag = current_user.aggregators.find(params[:id])
    respond_to do |format|
      if ag.update(aggregator_params)
        format.js {
          redirect_to "index", notice: "Aggregator updated successfuly"
        }
      else
        format.js {
          flash[:alert] = ag.errors.full_messages.first
          flash.discard
          render partial: "shared/error", status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    current_user.aggregators.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private

  def aggregator_params
    params.require(:aggregator).permit(:title)
  end
end
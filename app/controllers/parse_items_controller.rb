class ParseItemsController < ApplicationController
  def change_status
    pi = ParseItem.find(params[:id])
    pi.update(status: :viewed)
    respond_to do |format|
      format.json{
        render json: { id: pi.id, count_new_items: current_user.new_items.count }, status: 200
      }
    end
  end

  def tagged
    if params[:tag].present?
      @parse_items = ParseItem.tagged_with(params[:tag])
    else
      @parse_items = ParseItem.all
    end
  end

  def chosen
    pi = ParseItem.find(params[:id])
    pi.update(chosen: !pi.chosen)
    respond_to do |format|
      format.json{
        render json: { id: pi.id, chosen: pi.chosen }, status: 200
      }
    end
  end

  private

  def parse_item_params
    params.require(:parse_item).permit(:data, :status, :chosen, :tag_list)
  end
end

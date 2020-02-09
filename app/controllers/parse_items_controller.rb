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
end

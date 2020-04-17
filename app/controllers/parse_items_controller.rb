class ParseItemsController < ApplicationController
  before_action :set_site, :set_parse_item
  
  def change_status
    if @parse_item.update(status: :viewed)
      respond_to do |format|
        format.json{
          render json: {}, status: :no_content
        }
      end
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
    if @parse_item.update(chosen: !@parse_item.chosen)
      respond_to do |format|
        format.json{
          render json: {}, status: :no_content
        }
      end
    end
  end

  private

  def set_site
    site = Site.find(params[:site_id])
    @site = site if current_user.aggregators.pluck(:id).include?(site.aggregator_id)
  end

  def set_parse_item
    @parse_item = @site.parse_items.find(params[:id])
  end

  def parse_item_params
    params.require(:parse_item).permit(:data, :status, :chosen, :tag_list)
  end
end

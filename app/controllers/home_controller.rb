class HomeController < ApplicationController
  
  def index
    @parse_items = UserParseItemsAll.call(current_user)
    @parse_items = @parse_items.search(params[:title]) if params[:title].present?
    @parse_items = @parse_items.where(chosen: params[:chosen]) if params[:chosen].present?
    @parse_items = @parse_items.where(status: params[:status]) if params[:status].present?
    
    if params[:created_at].present?
      date = Date.strptime(params[:created_at], "%d.%m.%y")
      @parse_items = @parse_items.where(created_at: date.beginning_of_day..date.end_of_day)
    end
    respond_to do |format|
      format.html {}
      format.json {
        render json: { 
          content: HomeController.render(partial: "parse_items", locals: { parse_items: @parse_items}, layout: false)
        }, status: :ok
      }
    end
  end
end

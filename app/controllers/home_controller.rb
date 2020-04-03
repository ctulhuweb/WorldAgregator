class HomeController < ApplicationController
  
  def index
    @per_page = 20
    @page = params[:page] || 1
    @page = @page.to_i
    @parse_items = UserParseItems.call(current_user)
    @parse_items = SearchParseItems.call(@parse_items, params)
    @total = @parse_items.count
    @parse_items = @parse_items.offset((@page - 1) * @per_page).limit(@page * @per_page)
    p "total: #{@total} page: #{@page} per_page: #{@per_page}"
    @show_pagination = @total > @page * @per_page
    respond_to do |format|
      format.html {}
      format.json {
        render json: { 
          content: HomeController.render(partial: "parse_items", locals: { parse_items: @parse_items, show_pagination: @show_pagination, page: @page }, layout: false),
          }, status: :ok
      }
    end
  end
end

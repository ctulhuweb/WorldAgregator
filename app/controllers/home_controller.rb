class HomeController < ApplicationController
  
  def index
    set_paginate_params
    @parse_items = UserParseItems.call(current_user)
    @parse_items = SearchParseItems.call(@parse_items, params[:search]) if params[:search].present?
    @total = @parse_items.count

    @parse_items = @parse_items.paginate(@page, @per_page)
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

  private

  def set_paginate_params
    @per_page = params[:per_page] || 20
    @page = params[:page] || 1
    @page = @page.to_i 
  end
end

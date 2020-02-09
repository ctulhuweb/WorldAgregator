class HomeController < ApplicationController
  
  def index
    @parse_items = ParseItem.joins(site: :user)
                            .where(users: { id: current_user.id })
                            .sort_by(&:status)
  end

  def search
    @parse_items = ParseItem.joins(site: :user)
                            .where(users: { id: current_user.id })
                            .search(params[:search]).sort_by(&:status)
    respond_to do |format|
      format.json {
        render json: { 
          content: HomeController.render(partial: "parse_items", locals: { parse_items: @parse_items}, layout: false)
         }, status: :ok
      }
    end
  end

end

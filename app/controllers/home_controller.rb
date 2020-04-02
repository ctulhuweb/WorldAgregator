class HomeController < ApplicationController
  
  def index
    @parse_items = UserParseItemsAll.call(current_user)
  end

  def search
    @parse_items = UserParseItemsAll.call(current_user).search(params[:search])
    respond_to do |format|
      format.json {
        render json: { 
          content: HomeController.render(partial: "parse_items", locals: { parse_items: @parse_items}, layout: false)
         }, status: :ok
      }
    end
  end

end

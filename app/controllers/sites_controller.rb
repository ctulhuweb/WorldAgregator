class SitesController < ApplicationController
  def index
    @sites = current_user.sites.sort_by { |s| s.name }
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    if @site.update(site_params)
      redirect_to action: 'index'
    else
      render "layouts/errors", locals: { resource: @site }, status: :unprocessable_entity
    end
  end

  def create
    @site = current_user.sites.build(site_params)
    if @site.save
      redirect_to action: 'index'
    else
      render "layouts/errors", locals: { resource: @site }, status: :unprocessable_entity
    end
  end

  def show
    @site = Site.find(params[:id])
  end

  def destroy
    current_user.sites.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def test_parse
    @site = Site.find(params[:id])
    data = Parser.get_data(@site)
    if data.present?
      pi = @site.parse_items.build(data: data[0], status: :new, created_at: Date.today)
      respond_to do |format|
        format.json {
          render json: { content: ParseItemsController.render(template: "sites/_test_parse", locals: { parse_item: pi }, layout: false)}, status: :ok
        }
      end
    else
      respond_to do |format|
        format.json {
          render json: { content: "empty" }, status: :ok
        }
      end
    end
  end

  private

  def site_params
    params.require(:site).permit(:name, :url, :main_selector)
    #params.require(:site).permit(:name, :url, parse_settings_attributes: [:id, :name, :selector])
  end
end

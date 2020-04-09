class SitesController < ApplicationController
  before_action :set_site, except: [:new, :index, :create]
  
  def index
    @sites = current_user.sites.order(:name)
  end

  def new
    @site = Site.new
  end

  def edit
  end

  def update
    @site = current_user.sites.find(params[:id])
    respond_to do |format|
      if @site.update(site_params)
        format.js { redirect_to action: 'index', notice: "Site successfuly updated." }
      else
        format.js {
          flash[:alert] = @site.errors.full_messages.first
          flash.discard
          render partial: "shared/error", status: :unprocessable_entity
        }
      end
    end
  end

  def create
    @site = current_user.sites.build(site_params)
    respond_to do |format|
      if @site.save
        format.js { redirect_to action: 'index', notice: "Site successfuly created." }
      else
        format.js {
          flash[:alert] = @site.errors.full_messages.first
          flash.discard
          render partial: "shared/error", status: :unprocessable_entity
        }
      end
    end
  end

  def show
  end

  def destroy
    @site.destroy
    respond_to do |format|
      format.js
    end
  end

  def test_parse
    data = Parser.get_data(@site)
    if data.present?
      pi = @site.parse_items.build(data: data[0], status: :new, created_at: Date.today)
      p pi.data
      respond_to do |format|
        format.json {
          render json: { content: ParseItemsController.render(template: "sites/_test_parse", locals: { parse_item: pi }, layout: false)}, status: :ok
        }
      end
    else
      respond_to do |format|
        format.json {
          render json: {}, status: :no_content
        }
      end
    end
  end

  def change_status
    if @site.update(active: !@site.active) 
      respond_to do |format|
        format.js {
          render partial: "card-info-update", locals: { site: @site }, status: :ok
        }
      end
    end
  end
  private

  def set_site
    @site = current_user.sites.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:name, :url, :main_selector, :active)
  end
end

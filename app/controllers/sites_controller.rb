class SitesController < ApplicationController
  before_action :set_aggregator, only: [:new, :index, :create]
  before_action :set_site, except: [:new, :index, :create]
  
  def index
    @sites = @ag.sites.order(:name)
  end

  def new
    @site = @ag.sites.build
  end

  def edit
  end

  def update
    raise ActiveRecord::RecordNotFound if @site.nil?
    respond_to do |format|
      if @site.update(site_params)
        format.js { redirect_to action: 'show', notice: "Site successfuly updated." }
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
    @site = @ag.sites.build(site_params)
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
    raise ActiveRecord::RecordNotFound if @site.nil?
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
          render partial: "card-info-update", locals: { site: SiteDecorator.new(@site) }, status: :ok
        }
      end
    end
  end
  private

  def set_site
    site = Site.find(params[:id])
    @site = site if current_user.aggregators.pluck(:id).include?(site.aggregator_id)
  end

  def set_aggregator
    @ag = current_user.aggregators.find(params[:aggregator_id])
  end

  def site_params
    params.require(:site).permit(:name, :url, :main_selector, :active, parse_fields_attributes: [:id, :name, :selector, :_destroy])
  end
end

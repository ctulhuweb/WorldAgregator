class ParseFieldsController < ApplicationController
  before_action :get_site

  def new
    @parse_field = @site.parse_fields.build
  end

  def create
    @pf = @site.parse_fields.build(parse_field_params)  
    respond_to do |format|
      if @pf.save
        format.js { redirect_to site_path(@pf.site), notice: "Parse Field was successfuly created." }
      else
        format.js {
          flash[:alert] = @pf.errors.full_messages.first
          flash.discard
          render partial: "error", status: :unprocessable_entity
        }
      end
    end
  end
  
  def edit
    @parse_field = ParseField.find(params[:id])
  end

  def destroy
    @site.parse_fields.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @parse_field = @site.parse_fields.find(params[:id])
    if @parse_field.update(parse_field_params)
      redirect_to site_path(@parse_field.site)
    end
  end

  private

  def parse_field_params
    params.require(:parse_field).permit(:name, :selector, :site_id, :field_type)
  end

  def get_site
    site = Site.find(params[:site_id])
    @site = site if current_user.aggregators.pluck(:id).include?(site.aggregator_id)
  end

end

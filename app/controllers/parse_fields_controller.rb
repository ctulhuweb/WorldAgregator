class ParseFieldsController < ApplicationController
  before_action :get_site

  def new
    @parse_field = @site.parse_fields.build
  end

  def create
    @pf = @site.parse_fields.build(parse_field_params)  
    if @pf.save
      redirect_to site_path(@pf.site)
    end
  end
  
  def edit
    @parse_field = ParseField.find(params[:id])
  end

  def destroy
    ParseField.destroy(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @parse_field = ParseField.find(params[:id])
    @parse_field.update(parse_field_params)
    redirect_to site_path(@parse_field.site)
  end

  private

  def parse_field_params
    params.require(:parse_field).permit(:name, :selector, :site_id)
  end

  def get_site
    @site = Site.find(params[:site_id])
  end

end

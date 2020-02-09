require "rails_helper"

RSpec.describe "ParseFields", type: :request do
  before(:each) do
    @user = create(:user)
    @site = create(:site, user: @user)
    sign_in @user
  end

  it "add a parse field" do
    parse_field_params = attributes_for(:parse_field)
    expect {
      post site_parse_fields_path(@site), params: { parse_field: parse_field_params, format: :js }
    }.to change(@site.parse_fields, :count).by(1)
  end

  it "not add with invalid params" do
    parse_field_params = attributes_for(:parse_field)
    parse_field_params[:name] = ""
    expect {
      post site_parse_fields_path(@site), params: { parse_field: parse_field_params, format: :js }
    }.not_to change(@site.parse_fields, :count)
  end
end
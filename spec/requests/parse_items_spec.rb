require "rails_helper"

RSpec.describe "ParseItems", type: :request do
  before(:each) do
    @user = create(:user)
    @site = create(:site, user: @user)
    @parse_item = create(:parse_item, site: @site)
    sign_in @user
  end

  it "change status of parse item" do
    expect {
      post change_status_parse_item_path(@site.parse_items.first), params: { format: :json }
    }.to change { @site.parse_items.first.status }
    expect(response).to have_http_status(200)
  end
end
require "rails_helper"

RSpec.describe "ParseItems", type: :request do
  before(:each) do
    @user = create(:user)
    @ag = create(:aggregator, user: @user)
    @site = create(:site, aggregator: @ag)
    @parse_item = create(:parse_item, site: @site)
    sign_in @user
  end

  describe '#change_status' do
    it "updates parse item status" do
      expect {
        patch change_status_site_parse_item_path(@site ,@site.parse_items.first), params: { format: :json }
      }.to change { @site.parse_items.first.status }.from("new").to("viewed")
      expect(response.body).to be_empty
      expect(response).to have_http_status(204)
    end

    it "update status own parse items" do
      parse_item = create(:parse_item)
      expect {
        patch change_status_site_parse_item_path(@site , parse_item), params: { format: :json }
      }.not_to change { parse_item.reload.status }
      expect(response).to have_http_status(404)
    end
  end

  describe '#chosen' do
    it "update chosen" do
      expect {
        patch chosen_site_parse_item_path(@site, @site.parse_items.first), params: { format: :json }
      }.to change { @site.parse_items.first.chosen }
      expect(response).to have_http_status(204)
    end

    it "update status own parse items" do
      parse_item = create(:parse_item)
      expect {
        patch chosen_site_parse_item_path(@site , parse_item), params: { format: :json }
      }.not_to change { parse_item.reload.chosen }
      expect(response).to have_http_status(404)
    end
  end
end
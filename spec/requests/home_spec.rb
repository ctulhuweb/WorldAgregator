require "rails_helper"

describe "Home management", type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe "#index" do
    before(:each) do
      @search_params = { title: "vasa?", created_at: Date.current.strftime("%d.%m.%y"), status: "new", chosen: true }
    end

    describe 'json format' do
      
      it "search form" do
        get root_path, params: { search: @search_params , format: :json }
        expect(JSON.parse(response.body)["content"]).to be_present
        expect(response).to have_http_status(200)
      end

      it "with a select of aggregator" do
        ag = create(:aggregator, user: @user)
        get root_path, params: { search: @search_params, aggregator_id: ag.id, format: :json }
        expect(response).to have_http_status(200)
      end
    end

    it "return html format" do
      get root_path
      expect(response).to have_http_status(200)
    end

  end
end
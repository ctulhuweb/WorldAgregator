require "rails_helper"

RSpec.describe "Sites manegement", type: :request do
  before(:each) do
    @user = create(:user)
    @site = create(:site, user: @user)
    sign_in @user
  end

  describe '#index' do
    it do
      get sites_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#new' do
    it do
      get new_site_path
      expect(response).to have_http_status(:success)
    end  
  end

  describe '#edit' do
    it do
      get edit_site_path(@site)
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    let!(:attributes) { attributes_for(:site) }
    it "updates site attributes" do
      expect {
        put site_path(@site), params: { site: attributes, format: :js }
      }.to change { @site.reload.updated_at }
      expect(response.status).to eq(302)
    end

    it "user updates only own sites" do
      another_site = create(:site)
      expect {
        put site_path(another_site), params: { site: attributes, format: :js }
      }.not_to change { @site.reload.updated_at }
      expect(response.status).to eq(404)
    end

    context "invalid attributes" do
      let!(:invalid_attributes) { attributes_for(:site, url: "") }
      it "return error" do
        put site_path(@site), params: { site: invalid_attributes, format: :js }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#create' do
    let!(:attributes) { attributes_for(:site)}
    it "creates a Site and redirect to sites" do
      expect { 
        post sites_path, params: { site: attributes, format: :js }
      }.to change(@user.sites, :count).by(1) 
      expect(response).to have_http_status(302)
    end

    context "invalid attributes" do
      let!(:invalid_attributes) { attributes_for(:site, url: "") }
      it "return error" do
        post sites_path, params: { site: invalid_attributes, format: :js }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#show' do
    it "site instance page" do
      get site_path(@site)
      expect(response).to have_http_status(:success)
    end
    
    it "show only sites of user" do
      another_site = create(:site)
      get site_path(another_site)
      expect(response).to have_http_status(404)
    end
  end
  
  describe '#destroy' do
    it "destroy site" do
      delete site_path(@site), params: { format: :js }
      expect(response.status).to eq(200)
    end  
  end
  
  describe '#test_parse' do
    it "parse one item from site" do
      VCR.use_cassette("parser/get_data") do
        real_site = create(:site, :real, user: @user)
        get test_parse_site_path(real_site), params: { format: :json }
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#change_status' do
    it "change status" do
      expect {
        patch change_status_site_path(@site), params: { format: :js}
      }.to change { @site.reload.active }
    end  
  end
end
require "rails_helper"

RSpec.describe "Sites manegement", type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  it "render new form" do
    get new_site_path
    expect(response).to have_http_status(:success)
  end

  it "creates a Site and redirect to sites" do
    expect { 
      post sites_path, params: { site: attributes_for(:site) }
    }.to change(@user.sites, :count).by(1)
    expect(response.status).to eq(302)
    expect(response).to redirect_to sites_path
  end

  it "show site instance page" do
    site = create(:site)
    get site_path(site)
    expect(response.body).to include("Name: #{site.name}")
  end

  it "destroy site" do
    site = create(:site, user: @user)
    delete site_path(site), params: { format: :js }
    expect(response.status).to eq(200)
  end

  it "update site attributes" do
    site = create(:site)
    put site_path(site), params: { site: attributes_for(:site) }
    expect(response.status).to eq(302)
  end

  context "invalid params" do
    it "show error message" do
      site = build(:site)
      site.name = ""
      post sites_path, params: { site: site.attributes, format: :js }
      expect(response.status).to eq(422)
    end
  end

  it "run test parse for site settings" do
    site = create(:site, user: @user)
    post test_parse_site_path(site), params: { format: :json }
    expect(response.status).to eq(200) 
  end
end
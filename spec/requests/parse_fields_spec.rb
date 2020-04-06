require "rails_helper"

RSpec.describe "ParseFields", type: :request do
  before(:each) do
    @user = create(:user)
    @site = create(:site, user: @user)
    sign_in @user
  end

  describe '#new' do
    it "return status success" do
      get new_site_parse_field_path(@site)
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    let(:parse_field_params) { attributes_for(:parse_field) }
    subject { post site_parse_fields_path(@site), params: { parse_field: parse_field_params, format: :js }}
    
    it "add a parse field" do
      expect{ subject }.to change(@site.parse_fields, :count).by(1)
    end

    it "redirect to site path" do
      subject
      expect(response).to have_http_status(302)
    end

    context "invalid attributes" do
      let(:parse_field_params) { attributes_for(:parse_field, name: "") }
      
      it "do not add a parse field" do
        expect { subject }.not_to change(@site.parse_fields, :count)
      end

      it "return unprocessable entity" do
        subject
        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#edit' do
    let(:parse_field) { create(:parse_field, site: @site) }
    it "return status success" do
      get edit_site_parse_field_path(@site, parse_field)
      expect(response).to have_http_status(200)
    end
  end

  describe '#destroy' do
    let!(:parse_field) { create(:parse_field, site: @site) }
    subject { delete site_parse_field_path(@site, parse_field), params: { format: :js } }

    it "delete a parse field of a site" do
      expect { subject }.to change(@site.parse_fields, :count).by(-1)
    end

    it "return status success" do
      subject
      expect(response).to have_http_status(200)
    end

    context "difference site and parse field" do
      it "doesn't delete" do
        site = create(:site)
        another_parse_field = create(:parse_field, site: site)
        expect { 
          delete site_parse_field_path(@site, another_parse_field), params: { format: :js } 
         }.not_to change(site.parse_fields, :count)
      end
    end
  end

  describe '#update' do
    let!(:parse_field) { create(:parse_field, site: @site) }
    let!(:attributes) { attributes_for(:parse_field) }
    subject { put site_parse_field_path(@site, parse_field), params: { parse_field: attributes , format: :js }}
    
    it "update a parse field" do
      expect { subject }.to change { parse_field.reload.updated_at }  
    end

    it "return status redirect" do
      subject
      expect(response).to have_http_status(302)
    end

    context "difference site and parse field" do
      it "doesn't update" do
        site = create(:site)
        another_parse_field = create(:parse_field, site: site)
        expect { 
          put site_parse_field_path(@site, another_parse_field), params: { parse_field: attributes , format: :js }
         }.not_to change { another_parse_field.reload.updated_at }
      end

      it "not found" do
        site = create(:site)
        another_parse_field = create(:parse_field, site: site)
        put site_parse_field_path(@site, another_parse_field), params: { parse_field: attributes , format: :js }
        expect(response).to have_http_status(404)
      end
    end
  end
end
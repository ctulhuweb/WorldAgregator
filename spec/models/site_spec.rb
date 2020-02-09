require 'rails_helper'

RSpec.describe Site, type: :model do
  describe "create" do
    context "is invalid" do
      before(:each) do
        @site = build_stubbed(:site)
      end

      it "without a name" do
        @site.name = nil
        @site.valid?
        expect(@site.errors[:name]).to include("can't be blank")
      end

      it "without a url" do
        @site.url = nil
        @site.valid?
        expect(@site.errors[:url]).to include("can't be blank")
      end

      it "with invalid url" do
        @site.url = "invalid.www.com"
        @site.valid?
        expect(@site.errors[:url]).to include("is invalid")
      end

      it "without a main selector" do
        @site.main_selector = nil
        @site.valid?
        expect(@site.errors[:main_selector]).to include("can't be blank")
      end

      it "without a user" do
        @site.user = nil
        @site.valid?
        expect(@site.errors[:user].size).to eq(1)
      end

    end

    context "is valid" do
      it "with valid attributes" do
        expect(build_stubbed(:site)).to be_valid
      end
    end
  end
end
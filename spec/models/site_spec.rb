require 'rails_helper'

RSpec.describe Site, type: :model do
  include_examples "#paginate"
  describe "create" do
    context "is invalid" do
      before(:each) do
        @site = build_stubbed(:site)
      end

      it_behaves_like "a model presence validation for", "name"
      it_behaves_like "a model presence validation for", "url"
      it_behaves_like "a model presence validation for", "main_selector"

      it "with invalid url" do
        @site.url = "invalid.www.com"
        @site.valid?
        expect(@site.errors[:url]).to include("is invalid")
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
require 'rails_helper'

RSpec.describe Site, type: :model do
  include_examples "#paginate"
  describe "new" do
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

      it "without a main selector" do
        @site.main_selector = nil
        @site.valid?
        expect(@site.errors[:main_selector]).to include("can't be blank")
      end

      it "without a aggregator" do
        @site.aggregator = nil
        @site.valid?
        expect(@site.errors[:aggregator].size).to eq(1)
      end
    end

    context "is valid" do
      it "with valid attributes" do
        expect(build_stubbed(:site)).to be_valid
      end
    end
  end

  describe 'Associations' do
    it_behaves_like "has a association", :user, :belongs_to
    it_behaves_like "has a association", :parse_fields, :has_many
    it_behaves_like "has a association", :parse_items, :has_many
  end

  describe 'Scopes' do
    before(:each) {
      @active_sites_count = 3
      @not_active_sites_count = 2
      create_list(:site, @active_sites_count, active: true)
      create_list(:site, @not_active_sites_count, active: false)
    }

    it '#active' do
      expect(described_class.active.count).to eq(@active_sites_count)
    end

    it '#not_active' do
      expect(described_class.not_active.count).to eq(@not_active_sites_count)
    end
  end
end
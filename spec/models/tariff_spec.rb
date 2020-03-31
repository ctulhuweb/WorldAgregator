require 'rails_helper'

RSpec.describe Tariff, type: :model do
  describe "create" do
    before(:each) do
      @tariff = create(:tariff)
    end

    context "is invalid" do
      it "with count sites empty or zero" do
        @tariff.count_sites = 0
        @tariff.valid?
        expect(@tariff.errors[:count_sites]).to include("must be greater than 0")
      end

      it "with parse interval zero" do
        @tariff.parse_interval = 0
        @tariff.valid?
        expect(@tariff.errors[:parse_interval]).to include("must be greater than 0")
      end

      it_behaves_like "a model presence validation for", "title"
    end
  end

  describe "scopes" do
    it "active" do
      create_list(:tariff, 3, active: true)
      create_list(:tariff, 2, active: false)
      expect(Tariff.active.count).to eq(3)
    end
  end

end

require 'rails_helper'

RSpec.describe Tariff, type: :model do
  describe "new" do
    before(:each) do
      @tariff = build(:tariff)
    end

    context "is invalid" do
      it "with count sites empty or not positive" do
        @tariff.count_sites = 0
        @tariff.valid?
        expect(@tariff.errors[:count_sites]).to include("must be greater than 0")
      end

      it "with parse interval empty or not positive" do
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

  describe 'associations' do
    it_behaves_like "has a association", :orders, :has_many
  end
end

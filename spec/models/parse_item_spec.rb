require "rails_helper"

RSpec.describe ParseItem, type: :model do
  context "is invalid" do
    before(:each) do
      @parse_item = build_stubbed(:parse_item)
    end

    it_behaves_like "a model presence validation for", "data"  
    it_behaves_like "a model presence validation for", "status"

    it "without a site" do
      @parse_item.site = nil
      @parse_item.valid?
      expect(@parse_item.errors[:site].size).to eq(1)
    end
  end
  
  context "is valid" do
    it "with valid attributes" do
      expect(build_stubbed(:parse_item)).to be_valid
    end
  end

  describe "search" do
    before(:each) do
      create_list(:parse_item, 5)
      create(:parse_item, data: {Title: "vassaaa", Description: "watsuppp?"})
      create(:parse_item, data: {Title: "vassaaa brazza", Description: "watsuppp?"})
    end

    it "return parse items by string" do
      expect(ParseItem.search("vassa").count).to eq (2)
    end

  end
end
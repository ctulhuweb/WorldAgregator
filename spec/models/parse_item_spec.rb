require "rails_helper"

RSpec.describe ParseItem, type: :model do
  include_examples "#paginate"
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

  describe "scopes" do
    before(:each) do
      @count_chosen_parse_items = 5
      @parse_items_today = 7
      create_list(:parse_item, @count_chosen_parse_items, chosen: true)
      create(:parse_item, data: {Title: "vassaaa", Description: "watsuppp?"})
      create(:parse_item, data: {Title: "vassaaa brazza", Description: "watsuppp?"})
    end

    it "#title" do
      expect(ParseItem.title("vassa").count).to eq (2)
    end

    it "#chosen" do
      expect(ParseItem.chosen.count).to eq(@count_chosen_parse_items)
    end

    it "#find_by_created_day" do
      expect(ParseItem.find_by_created_day(Date.current).count).to eq(@parse_items_today)
    end
  end
end
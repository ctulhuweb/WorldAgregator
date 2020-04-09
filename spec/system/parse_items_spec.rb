require "rails_helper"

RSpec.describe 'Parse items', type: :system, js: true do
  before(:each) do
    user = create(:user)
    sign_in user
    @site = create(:site, :with_two_parse_items, user: user)
    visit root_path
  end
  
  describe 'block' do
    let!(:parse_item) { find(".parse-item", match: :first) }
    
    it "contains" do
      expect(parse_item).to have_content(@site.name)
      selectors = [".card-header", ".list-group", ".card-footer"]
      selectors.each do |s|
        expect(parse_item).to have_selector(s)
      end
    end

    describe 'parse item actions' do
      it "change status" do
        parse_item = find(".parse-item", match: :first)
        status = parse_item.find(".parse-item__status", text: "New")
        status.click
        expect(status).to have_content("Viewed")
      end

      it "can be chosen by user" do
        parse_item = find(".parse-item", match: :first)
        chosen = parse_item.find(".fa-star")
        chosen.click
        expect(parse_item).to have_selector(".fa-star_chosen")
      end
    end
  end
end
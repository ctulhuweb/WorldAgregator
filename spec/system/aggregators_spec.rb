require "rails_helper"

RSpec.describe 'Aggregators Management', type: :system do
  before(:each) do
    @user = create(:user)
    @aggregator = create(:aggregator, user: @user)
    sign_in @user
    visit aggregators_path
  end

  describe '#index' do
    it "render all user's aggregators" do
      expect(page).to have_selector(".aggregators")
      expect(page).to have_selector(".aggregator")
      expect(page).to have_content(@aggregator.title)
    end
  end

  scenario 'add aggregator', js: true do
    find(".link-add").click
    within("form") do
      fill_in "Title", with: "new aggregor"
    end
    click_button "Save"
    expect(page).to have_selector(".aggregator", count: 2)
    expect(page).to have_content(@aggregator.title)
  end

  scenario 'delete aggregator', js: true, focus: true do
    find(".aggregator").hover
    find(".action_delete").click
    expect(page).not_to have_selector(".aggregator") 
  end

  scenario 'edit aggregator', js: true, focus: true do
    find(".aggregator").hover
    find(".action_edit").click
    within("form") do
      fill_in "Title", with: "Edit aggregator"
    end
    click_button "Save"
    expect(page).to have_selector(".aggregator", count: 1)
    expect(page).to have_content("Edit aggregator")
    expect(page).to have_content("less than a minute")
  end
end
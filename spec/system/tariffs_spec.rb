require "rails_helper"

RSpec.describe "Tariffs management", type: :system do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  scenario "User move to page of tariffs by link in header" do
    visit root_path
    expect(page).to have_content("Tariffs")
    click_on("Tariffs")
    expect(page).to have_css(".tariffs")
  end

  it "only active tariffs" do
    active_tariffs = create_list(:tariff, 3, active: true)
    tariff4 = create(:tariff)
    visit tariffs_path
    expect(page).to have_selector(".tariff", maximum: 3)
    active_tariffs.each do |t|
      expect(page).to have_content(t.title)
    end
  end

end
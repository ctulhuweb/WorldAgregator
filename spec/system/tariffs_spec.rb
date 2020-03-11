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

  it "check data tariffs in cards" do
    tariff1 = create(:tariff, title: "tariff1", count_sites: "1", parse_interval: 10)
    tariff2 = create(:tariff, title: "tariff2", count_sites: "2", parse_interval: 5)
    tariff3 = create(:tariff, title: "tariff3", count_sites: "3", parse_interval: 1)
    tariff4 = create(:tariff, title: "tariff4", count_sites: "4", parse_interval: 4)
    visit tariffs_path
    expect(page).to have_selector(".tariff", maximum: 3)

    expect(page).to have_content("tariff1")
    expect(page).to have_content("tariff2")
    expect(page).to have_content("tariff3")
  end

end
require "rails_helper"

RSpec.describe "Sites managemet", type: :system, js: true do
  before(:each) do
    @user = create(:user)
    @ag = create(:aggregator, user: @user)
    sign_in @user
  end

  scenario "create" do
    site = build(:site, aggregator: @ag)
    visit root_path
    click_link "Aggregator"
    find(".aggregator").click
    click_link "Add Site"
    within("form") do
      fill_in "site_name", with: site.name
      fill_in "site_url", with: site.url
      fill_in "site_main_selector", with: site.main_selector
      click_button "Save"
    end
    expect(page).to have_selector("table")
    expect(page).to have_content(site.name)
    expect(page).to have_content(site.url)
  end

  scenario "edit" do
    site = create(:site, aggregator: @ag)
    new_site = build(:site, aggregator: @ag)
    visit aggregator_sites_path(@ag)
    click_link "Edit"
    within("form") do
      fill_in "site_name", with: new_site.name
      fill_in "site_url", with: new_site.url
      fill_in "site_main_selector", with: new_site.main_selector
      click_button "Save"
    end
    expect(page).to have_selector("table")
    expect(page).to have_content(new_site.name)
    expect(page).to have_content(new_site.url)
  end

  scenario "delete" do
    site = create(:site, aggregator: @ag)
    visit aggregator_sites_path(@ag)
    click_link "Delete"
    expect(page).not_to have_content(site.name)
    expect(page).not_to have_selector("tr", count: 2)
  end

  scenario "change status active" do
    site = create(:site, aggregator: @ag)
    visit aggregator_sites_path(@ag)
    expect(page).to have_selector(".fa-ban")
    click_link "Setting"
    click_button "Enable"
    card = find(".card")
    expect(card).to have_content("Status: Active")
    click_button "Disable"
    expect(card).to have_content("Status: Not active")
    click_button "Enable"
    visit aggregator_sites_path(@ag)
    expect(page).to have_selector(".fa-check")
  end

  scenario "test parse" do
    site = create(:site, :real, aggregator: @ag)
    visit site_path(site)
    find(".test-parse-js", text: "Test parse").click
    expect(page).to have_selector(".parse-item")
  end

  describe 'Parse field actions' do
    let!(:site) { create(:site, aggregator: @ag) }

    scenario "create parse field" do
      parse_field = build(:parse_field)
      visit site_path(site)
      click_link "Add Parse setting"
      within("form") do
        fill_in "parse_field_name", with: parse_field.name
        fill_in "parse_field_selector", with: parse_field.selector
        select("link", from: "parse_field_field_type")
        click_button "Submit"
      end
      expect(page).to have_content(parse_field.name)
      expect(page).to have_content(parse_field.selector)
    end

    scenario "edit parse field" do
      parse_field = create(:parse_field, site: site)
      visit site_path(site)
      click_link "Edit"
      new_attr = attributes_for(:parse_field)
      within("form") do
        fill_in "parse_field_name", with: new_attr[:name]
        fill_in "parse_field_selector", with: new_attr[:selector]
        select("link", from: "parse_field_field_type")
        click_button "Submit"
      end
      expect(page).to have_content(new_attr[:name])
      expect(page).to have_content(new_attr[:selector])
    end

    scenario "delete parse field" do
      parse_field = create(:parse_field, site: site)
      visit site_path(site)
      click_link "Delete"
      expect(page).not_to have_content(parse_field.name)
      expect(page).not_to have_selector("tr", count: 2)
    end
  end
end
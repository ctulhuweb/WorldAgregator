require "rails_helper"

RSpec.describe 'Home', type: :system do
  let!(:user) { create(:user) }
  scenario 'visits home page' do
    visit root_path
    expect(page).to have_content 'World Agregetor'
  end

  scenario 'sign_in' do
    visit root_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign in"
    expect(current_path).to eq root_path
  end

  describe 'search field' do
    before(:each) do 
      sign_in user
    end

    it "render only on home page" do
      visit root_path
      expect(page).to have_button "Search"
    end

    it "doesn't render on another pages" do
      visit sites_path
      expect(page).not_to have_button "Search"
    end

    context 'with valid parameter' do
      before(:each) do
        site = create(:site, user: user)
        create(:parse_item, site: site, data: {'Title': "what we want found"})
        create(:parse_item, site: site, data: {'Title': "another one"})
        create(:parse_item, site: site, data: {'Title': "one more another one"})
        visit root_path
        fill_in "search", with: "what we want"
        click_button "Search"
      end
      
      it 'return found items' do
        expect(page).to have_content "what we want found"
      end

      it 'doesn\'t return another' do
        expect(page).not_to have_content "another one"
      end
    end
  end

  describe "Header" do
    before(:each) do 
      sign_in user
    end

    it "Nav links become active when user moves on pages" do
      visit sites_path
      expect(page.find(".active")).to have_content('Sites')
      visit tariffs_path
      expect(page.find(".active")).to have_content('Tariffs')
      visit root_path
      expect(page.find(".active")).to have_content('Home')
    end

    # it "Settings in header" do
    #   visit root_path
    #   find(".avatar").click
    #   expect(page).to have_content(user.email)
    #   expect(page).to have_selector('.btn-profile', text: 'Profile')
    # end

  end
end
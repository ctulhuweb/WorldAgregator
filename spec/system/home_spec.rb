require "rails_helper"

RSpec.describe 'Home', type: :system, js: true do
  let!(:user) { create(:user) }
  
  scenario 'visits home page' do
    visit root_path
    expect(page).to have_content 'World Agregetor'
  end

  context "unauthorized user" do
    before(:each) do
      visit root_path
    end
    
    it "redirect to sign in" do
      expect(page).to have_content("Sign in")
      expect(page).to have_selector(".form-signin")
    end

    it "render standart header" do
      navigation_link = 3
      expect(page).to have_selector(".header .navbar-nav")
      expect(page).to have_selector(".nav-item", maximum: 3)
      expect(page.find(".header")).to have_link("Sign in")
    end

    it "support links" do
      expect(page).to have_link("Sign up")
      expect(page).to have_link("Forgot your password?")
    end
  end

  scenario 'sign_in' do
    visit root_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign in"
    expect(current_path).to eq root_path
  end

  describe 'search form' do
    before(:each) do
      sign_in user
      site = create(:site, user: user)
      create(:parse_item, site: site, data: {'Title': "what we want found"}, chosen: true)
      pi = create(:parse_item, :yesterday, site: site, data: {'Title': "another one"}, chosen: true, status: "viewed")
      create(:parse_item, :yesterday, site: site, data: {'Title': "one more another one"}, chosen: true, status: "viewed")
      create_list(:parse_item, 3, site: site, status: "viewed")
      @created_at = pi.created_at
      visit root_path
    end

    it "only on home page" do
      expect(page).to have_selector ".btn-open-search"
    end

    it "show on click btn" do
      click_button(class: "btn-open-search")
      expect(page).to have_selector ".search-form"
    end

    context 'with valid parameter' do
      before(:each) do
        click_button(class: "btn-open-search")
      end
      
      it "by title" do
        within(".search-form") do
          fill_in "title", with: "what we want found"
        end
        page.find("body").click # change focus
        expect(page).to have_selector(".parse-item", minimum: 1)
      end

      # TODO
      # it "by date" do
      #   within(".search-form") do
      #     fill_in "datepicker", with: @created_at.strftime("%d.%m.%y")
          
      #   end
      #   page.find(".datepicker--cell[data-date='1']").click
      #   sleep 2
      #   expect(page).to have_selector(".parse-item", minimum: 1)
      # end

      it "by status" do
        within(".search-form") do
          select("viewed", from: "status")
        end
        expect(page).to have_selector(".parse-item", count: 5)
      end

      it "by chosen" do
        within(".search-form") do
          find(".custom-checkbox .custom-control-label").click
        end
        expect(page).to have_selector(".parse-item", count: 1)
      end

      it "by all fields" do
        within(".search-form") do
          fill_in "title", with: "another one"
          fill_in "datepicker", with: @created_at.strftime("%d.%m.%y")
          find(".custom-checkbox .custom-control-label").click
          select("viewed", from: "status")
        end
        sleep 2
        expect(page).to have_selector(".parse-item", count: 2)
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

  end
end
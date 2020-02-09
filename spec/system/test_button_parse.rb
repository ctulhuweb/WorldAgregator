require "rails_helper"

RSpec.describe "Parser", type: :system do
  before(:each) do
    @user = create(:user)
    @site = create(:site, user: @user)
    sign_in @user
  end

  describe "button for test parse in settings" do
    it "exist" do
      visit sites_path
      click_on "Setting"
      expect(page).to have_content "Test parse"
    end
    
    it "create test block" do
      #TODO
    end
  end

end
require "rails_helper"

RSpec.describe "Sites managemet", type: :system do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe "#show" do
    let!(:site) { create(:site, user: @user) }
    before(:each) { visit site_path(site) }

    it "render button for change status" do
      expect(page).to have_content("Enable")
    end

    it "change status by click button" do
      click_button("Enable")
      expect(page).to have_content("Active")
      expect(page).to have_content("Disable")
    end
  end
end
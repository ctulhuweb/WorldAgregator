require "rails_helper"

describe "Home management", type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe "#search" do
    it "return success" do
      get search_path, params: { search: "vasa?" , format: :json} 
      expect(response).to have_http_status(200)
    end
  end


end
require "rails_helper"

RSpec.describe "Tariffs management", type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe '#index' do
    it do
      get tariffs_path
      expect(response).to have_http_status(200)
    end

  end

end
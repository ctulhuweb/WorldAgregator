require "rails_helper"
require "open-uri"

RSpec.describe Parser do
  describe "#get_data" do
    before(:each) do
      @site = create(:site)
      @site.url = "https://krsk.besposrednika.ru/"
      @site.main_selector = ".sEnLiCell"
      @site.active = true
      create(:parse_field, site: @site, name: "Date", selector: ".sEnLiDate")
      create(:parse_field, site: @site, name: "Title", selector: ".sEnLiTitle")
    end
    
    context "error receiving data from the site" do
      it "with invalid url" do
        @site.url = "http://invalid.valid"
        expect(Parser.get_data(@site)).to be_nil
      end
    end

    it "return data for one parse item" do
      VCR.use_cassette("parser/get_data") do
        data = Parser.get_data(@site)
        expect(data).not_to be_nil
      end
    end

  end


end
require "rails_helper"

RSpec.describe ParseField, type: :model do
  context "is invalid" do
    before(:each) do
      @parse_field = build(:parse_field)  
    end
    
    it "without a name" do
      @parse_field.name = nil
      @parse_field.valid?
      expect(@parse_field.errors[:name]).to include("can't be blank")
    end

    it "without a selector" do
      @parse_field.selector = nil
      @parse_field.valid?
      expect(@parse_field.errors[:selector]).to include("can't be blank")
    end

    it "without a site" do
      @parse_field.site = nil
      @parse_field.valid?
      expect(@parse_field.errors[:site]).to include("must exist")
    end
  end

  context "is valid" do
    it "with valid attributes" do
      expect(build_stubbed(:parse_field)).to be_valid
    end
  end
end
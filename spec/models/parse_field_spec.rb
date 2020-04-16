require "rails_helper"

RSpec.describe ParseField, type: :model do
  context "is invalid" do
    subject { build(described_class.to_sym) }
    
    it_behaves_like "a model presence validation for", "name"
    it_behaves_like "a model presence validation for", "selector"
    
    it "without a site" do
      subject.site = nil
      subject.valid?
      expect(subject.errors[:site]).to include("must exist")
    end
  end

  context "is valid" do
    it "with valid attributes" do
      expect(build_stubbed(:parse_field)).to be_valid
    end
  end

  describe 'Associations' do
    it_behaves_like "has a association", :site, :belongs_to
  end
end
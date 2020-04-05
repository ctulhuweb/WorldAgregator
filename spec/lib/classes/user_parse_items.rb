require "rails_helper"

RSpec.describe UserParseItems do
  subject { described_class }

  it "return parse items from all user websrabers" do
    user = create(:user)
    create_list(:site, 3, :with_two_parse_items, user: user)
    expect(described_class.call(user).count).to eq(6)
  end
end
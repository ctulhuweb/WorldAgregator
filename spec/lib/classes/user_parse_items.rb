require "rails_helper"

RSpec.describe UserParseItems do
  subject { described_class }
  let(:user) { create(:user) }
  let(:aggregator) { create(:aggregator, user: user)}

  it "return parse items from all user websrabers" do
    create_list(:site, 3, :with_two_parse_items, aggregator: aggregator)
    expect(subject.call(user).count).to eq(6)
  end

  it "return parse item for separate aggregator" do
    create_list(:site, 1, :with_two_parse_items, aggregator: aggregator)
    create_list(:site, 2, :with_two_parse_items)
    expect(subject.call(user, aggregator.id).count).to eq(2)
  end
end
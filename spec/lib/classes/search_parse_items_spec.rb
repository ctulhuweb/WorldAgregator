require "rails_helper"

RSpec.describe SearchParseItems do
  subject { described_class }

  it "return filtered parse items" do
    create_list(:parse_item, 3, chosen: true)
    create_list(:parse_item, 4, status: "viwed")
    create_list(:parse_item, 2, data: { Title: "COVID-19"}, chosen: true)
    @parse_items = ParseItem.all
    searched_items = described_class.call(@parse_items, { chosen: true, title: "COVID-19" })
    expect(searched_items.count).to eq(2)

    searched_items = described_class.call(@parse_items, { status: "viwed" })
    expect(searched_items.count).to eq(4)

    searched_items = described_class.call(@parse_items, { status: "viwed", chosen: true})
    expect(searched_items.count).to eq(0)
  end
end
require "rails_helper"

RSpec.describe SiteDecorator do
  let(:site) { create(:site) }
  subject { described_class.new(site) }

  it "#url_info" do
    expect(subject.url_info).to eq("Url: #{site.url}")
  end

  it "#status_info" do
    expect(subject.status_info).to eq("Status: Not active")
  end

  it "#active_btn_title" do
    expect(subject.active_btn_title).to eq("Enable")
  end

  it "#active_btn_style" do
    expect(subject.active_btn_style).to eq("success")
  end
end
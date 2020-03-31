require "rails_helper"

RSpec.shared_examples "name invalid" do |factory_name|
  subject { build(factory_name) }

  it "without a name" do
    subject.name = nil
    subject.valid?
    expect(subject.errors[:name]).to include("can't be blank")
  end
end
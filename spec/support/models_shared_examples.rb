RSpec.shared_examples "a model presence validation for" do |attribute_name|
  subject { build(described_class.to_sym) }

  it "without a #{attribute_name}" do
    subject.send("#{attribute_name}=", nil)
    subject.valid?
    expect(subject.errors[attribute_name.to_sym]).to include("can't be blank")
  end
end

RSpec.shared_examples "#paginate" do
  let(:records) { create_list(described_class.to_sym, 10) }

  it "return first 5 records" do
    expect(described_class.paginate(1, 5)).to eq(records.first(5))
  end

  it "return next 5 record" do
    expect(described_class.paginate(2, 5)).to eq(records.last(5))
  end
end
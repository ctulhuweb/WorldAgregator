class Object
  def self.to_sym
    name.underscore.to_sym
  end
end

RSpec.shared_examples "a model presence validation for" do |attribute_name|
  subject { build(described_class.to_sym) }

  it "without a #{attribute_name}" do
    subject.send("#{attribute_name}=", nil)
    subject.valid?
    expect(subject.errors[attribute_name.to_sym]).to include("can't be blank")
  end
end

RSpec.shared_examples "doesn't a render item on" do |item|
  it "#{item}" do
    expect(subject).not_to have_button item
  end
end
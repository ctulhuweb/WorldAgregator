class Object
  def self.to_sym
    name.underscore.to_sym
  end
end

RSpec.shared_examples "doesn't a render item on" do |item|
  it "#{item}" do
    expect(subject).not_to have_button item
  end
end
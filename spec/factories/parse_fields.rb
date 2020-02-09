FactoryBot.define do
  factory :parse_field do
    name { "Title" }
    selector { ".title" }
    site
  end
end
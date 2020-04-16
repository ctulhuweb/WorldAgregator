FactoryBot.define do
  factory :parse_field do
    name { Faker::Company.name }
    selector { ".title" }
    site
  end
end
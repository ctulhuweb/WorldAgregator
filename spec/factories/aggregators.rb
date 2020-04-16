FactoryBot.define do
  factory :aggregator do
    title { Faker::App.name }
    user
  end
end

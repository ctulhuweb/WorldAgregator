FactoryBot.define do
  factory :tariff do
    title { "MyString" }
    count_sites { 1 }
    parse_interval { 1 }
    price_cents { 100 }
    active { true }
  end
end

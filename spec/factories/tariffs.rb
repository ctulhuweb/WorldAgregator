FactoryBot.define do
  factory :tariff do
    sequence(:title) { |n| "Tariff#{n}" }
    count_sites { 1 }
    parse_interval { 1 }
    price_cents { 100 }
    active { false }
  end
end

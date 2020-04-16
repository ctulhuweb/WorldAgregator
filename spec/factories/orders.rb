FactoryBot.define do
  factory :order do
    user
    tariff
    status { "active" }
  end
end

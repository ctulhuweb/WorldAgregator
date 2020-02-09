FactoryBot.define do
  factory :site do
    name { Faker::Company.name }
    url { Faker::Internet.url(host: "example.com") }
    main_selector { ".block" }
    active { false }
    user

    trait :with_new_parse_items do
      after(:create) do |site| 
        create_list(:parse_item, 2, site: site)
      end
    end
  end
end
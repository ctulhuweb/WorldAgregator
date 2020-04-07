FactoryBot.define do
  factory :site do
    name { Faker::Company.name }
    url { Faker::Internet.url(host: "example.com") }
    main_selector { ".block" }
    active { false }
    user

    trait :with_two_parse_items do
      after(:create) do |site| 
        create_list(:parse_item, 2, site: site)
      end
    end

    trait :real do
      name { "Real" }
      url { "https://krsk.besposrednika.ru/" }
      main_selector { ".sEnLiCell" }
      active { true }

      after(:create) do |site|
        create(:parse_field, site: site, name: "Date", selector: ".sEnLiDate")
        create(:parse_field, site: site, name: "Title", selector: ".sEnLiTitle")
      end
    end
  end
end
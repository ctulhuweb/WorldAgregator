FactoryBot.define do
  factory :parse_item do
    data {{ Title: Faker::Lorem.sentence(word_count: 3), 
            Desc: Faker::Lorem.paragraph(sentence_count: 3) 
          }}
    status { :new }
    site
    chosen { false }

    trait :yesterday do
      after :create do |parse_item|
        parse_item.update(created_at: parse_item.created_at - 1.day)
      end
    end
  end
end
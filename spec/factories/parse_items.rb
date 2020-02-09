FactoryBot.define do
  factory :parse_item do
    data {{ Title: Faker::Lorem.sentence(word_count: 3), 
            Desc: Faker::Lorem.paragraph(sentence_count: 3) 
          }}
    status { :new }
    site
  end
end
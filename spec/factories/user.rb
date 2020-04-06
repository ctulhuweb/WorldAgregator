FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    
    trait :with_avatar do
      after(:build) do |user|
        user.avatar = File.open(Rails.root.join("spec", "factories", "images", "ruby.png"))
      end
    end
  end
end
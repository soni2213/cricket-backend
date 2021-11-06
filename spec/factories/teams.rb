FactoryBot.define do
  factory :team do
    name { Faker::Name.name }

    trait :with_players do
      after(:create) do |team|
        FactoryBot.create(:player, team: team)
      end
    end
  end
end

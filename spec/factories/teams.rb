# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_teams_on_name  (name) UNIQUE
#
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

FactoryBot.define do
  factory :player do
    sequence(:name) { |n| "#{team.name}Player#{n}" }
    team { create(:team) }
  end
end

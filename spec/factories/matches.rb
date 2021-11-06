FactoryBot.define do
  factory :match do
    team1 { create(:team) }
    team2 { create(:team) }
    status { 'in_progress' }

    trait :with_winner do
      winner { team1 }
      status { 'completed' }
    end

    trait :with_toss_winner do
      toss_winner { team1 }
      status { 'toss' }
    end
  end
end

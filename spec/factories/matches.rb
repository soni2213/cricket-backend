# == Schema Information
#
# Table name: matches
#
#  id             :bigint           not null, primary key
#  status         :string           default("planned")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  team1_id       :integer          not null
#  team2_id       :integer          not null
#  toss_winner_id :integer
#  winner_id      :integer
#
# Indexes
#
#  index_matches_on_team1_id   (team1_id)
#  index_matches_on_team2_id   (team2_id)
#  index_matches_on_winner_id  (winner_id)
#
FactoryBot.define do
  factory :match do
    team1 { create(:team) }
    team2 { create(:team) }
    status { 'toss' }
    toss_winner { team1 }

    trait :with_winner do
      winner { team1 }
      status { 'completed' }
    end
  end
end

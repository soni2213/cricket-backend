# frozen_string_literal: true

# == Schema Information
#
# Table name: balls
#
#  id         :bigint           not null, primary key
#  extra      :boolean          default(FALSE), not null
#  score      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  batsman_id :integer          not null
#  bowler_id  :integer          not null
#  match_id   :integer          not null
#
# Indexes
#
#  index_balls_on_match_id  (match_id)
#
FactoryBot.define do
  factory :ball do
    score { (0..6).to_a.sample }
    batsman { FactoryBot.create(:player, team: FactoryBot.create(:team)) }
    bowler { FactoryBot.create(:player, team: FactoryBot.create(:team)) }
  end
end

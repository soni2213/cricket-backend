# == Schema Information
#
# Table name: wickets
#
#  id          :bigint           not null, primary key
#  wicket_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ball_id     :integer          not null
#  batsman_id  :integer          not null
#  bowler_id   :integer          not null
#  fielder_id  :integer
#
FactoryBot.define do
  factory :wicket do
    ball
    wicket_type { 'lbw' }
    bowler_id { ball.bowler_id }
    batsman_id { ball.batsman_id }
  end
end

FactoryBot.define do
  factory :wicket do
    ball
    wicket_type { 'lbw' }
    bowler_id { ball.bowler_id }
    batsman_id { ball.batsman_id }
  end
end

class Ball < ApplicationRecord

  belongs_to :batsman, class_name: 'Player', foreign_key: 'batsman_id'
  belongs_to :bowler, class_name: 'Player', foreign_key: 'bowler_id'
  belongs_to :match

  has_one :wicket

  validates :score, presence: true

  validate :max_balls_per_team_in_match
  validate :bowler_batsman_team
  validate :bowler_fielder_team
  validate :batsman_team

  attr_accessor :wicket_type, :fielder_id

  before_create :record_wicket

  private

  def record_wicket
    return unless wicket_type.present?

    self.wicket = Wicket.new(bowler_id: bowler_id,
                               batsman_id: batsman_id,
                               wicket_type: wicket_type,
                               fielder_id: fielder_id)
  end

  def max_balls_per_team_in_match
    if (match.balls.where(extra: false, batsman_id: match.team1.player_ids).count >= Match::TOTAL_BALLS ||
        match.balls.where(extra: false, batsman_id: match.team2.player_ids).count >= Match::TOTAL_BALLS)
      errors.add(:base, "Only #{Match::TOTAL_BALLS} balls are permitted.")
    end
  end

  def bowler_batsman_team
    return if bowler.team_id != batsman.team_id

    errors.add(:base, "Bowler and batsman can't be of same team")
  end

  def balls_played
    match.balls.where(extra: false).count
  end

  def bowler_fielder_team
    toss_winner_id = match.toss_winner.id
    if (match.balls.where(extra: false, batsman_id: toss_winner_id.player_ids).count < Match::TOTAL_BALLS && (
        bowler.team_id ==  toss_winner_id || fielder.team_id == toss_winner_id)
       )
    errors.add(:base, "Bowler or fielder can't be of toss winning team until match overs are complete")
  end

  def batsman_team
    toss_winner_id = match.toss_winner.id
    if (match.balls.where(extra: false, batsman_id: toss_winner_id.player_ids).count < Match::TOTAL_BALLS && (
        batsman.team_id != toss_winner_id)
       )
    errors.add(:base, "Batsman should be of toss winning team until match overs are complete")
  end
end

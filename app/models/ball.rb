class Ball < ApplicationRecord

  scope :not_extra, -> { where(extra: false) }
  scope :played_by_team, -> (team){ not_extra.where(batsman_id: team.player_ids) }

  belongs_to :match
  belongs_to :batsman, class_name: 'Player', foreign_key: 'batsman_id'
  belongs_to :bowler, class_name: 'Player', foreign_key: 'bowler_id'

  has_one :wicket, autosave: true, dependent: :destroy

  validates :score, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 0,
                      less_than_or_equal_to: 7 # max six runs boundary on a no-ball (6 + 1)
                    }

  validate :max_balls_per_team_in_match, :bowler_batsman_team

  attr_accessor :wicket_type, :fielder_id
  before_create :record_wicket

  delegate :team1, :team1_id, :team2, :team2_id, :toss_winner, to: :match
  delegate :fielder, to: :wicket, allow_nil: true

  private

  def record_wicket
    return unless wicket_type.present?

    self.build_wicket(bowler_id: bowler_id,
                      batsman_id: batsman_id,
                      wicket_type: wicket_type,
                      fielder_id: fielder_id)

    raise(ActiveRecord::RecordInvalid, wicket) unless wicket.valid?
  end

  def max_balls_per_team_in_match
    return unless match

    max_balls = Match::TOTAL_BALLS
    # if team1 is batting and has exhausted max no. of balls permitted and this new record is for team1 only,
    # similar OR for team2
    if (match.balls.played_by_team(team1).count >= max_balls && batsman.team_id == team1_id) ||
       (match.balls.played_by_team(team2).count >= max_balls && batsman.team_id == team2_id)
      errors.add(:base, "Only #{max_balls} balls are permitted.")
    end
  end

  def bowler_batsman_team
    return if bowler&.team_id != batsman&.team_id

    errors.add(:base, "Bowler and batsman can't be of same team")
  end

  def balls_played
    match.balls.not_extra.count
  end
end

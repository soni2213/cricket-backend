class Match < ApplicationRecord

  TOTAL_BALLS = 120
  STATUSES = %w[planned toss in_progress completed]

  belongs_to :team1, class_name: 'Team', foreign_key: 'team1_id'
  belongs_to :team2, class_name: 'Team', foreign_key: 'team2_id'
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  belongs_to :toss_winner, class_name: 'Team', foreign_key: 'toss_winner_id', optional: true

  has_many :balls, dependent: :destroy
  has_many :wickets, dependent: :destroy

  validates :status, inclusion: STATUSES
  validate :team_duplicacy

  def toss_loser
    if team1_id == toss_winner_id
      Team.find(team2_id)
    else
      Team.find(team1_id)
    end
  end

  def in_progress?
    status.to_sym == :in_progress
  end

  def team_duplicacy
    return unless team1 == team2

    errors.add(:base, "Both teams need to be different.")
  end
end

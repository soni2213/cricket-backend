# frozen_string_literal: true

class Match < ApplicationRecord
  TOTAL_BALLS = 120
  STATUSES = %w[planned toss in_progress completed].freeze

  belongs_to :team1, class_name: 'Team', foreign_key: 'team1_id'
  belongs_to :team2, class_name: 'Team', foreign_key: 'team2_id'
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id', optional: true
  belongs_to :toss_winner, class_name: 'Team', foreign_key: 'toss_winner_id'

  has_many :balls, dependent: :destroy
  has_many :wickets, through: :balls, dependent: :destroy

  validates :status, inclusion: STATUSES
  validates :status, presence: true
  validate :team_duplicacy, :toss_winner_team, :winner_team

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

  private

  def team_duplicacy
    return unless team1 == team2

    errors.add(:base, 'Both teams need to be different.')
  end

  def toss_winner_team
    return if [team1_id, team2_id].include?(toss_winner_id)

    errors.add(:toss_winner, 'Must either be team1 or team2')
  end

  def winner_team
    return if [nil, team1_id, team2_id].include?(winner_id)

    errors.add(:winner, 'Must either be team1 or team2')
  end
end

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

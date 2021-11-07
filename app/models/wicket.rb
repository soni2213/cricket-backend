# frozen_string_literal: true

class Wicket < ApplicationRecord
  belongs_to :batsman, class_name: 'Player', foreign_key: 'batsman_id'
  belongs_to :bowler, class_name: 'Player', foreign_key: 'bowler_id'
  belongs_to :fielder, class_name: 'Player', foreign_key: 'fielder_id', optional: true
  belongs_to :ball

  validates :wicket_type, presence: true
  validate :batsman_fielder_team, :bowler_fielder_team, if: :fielder_present?
  validate :max_wickets, :fielder_presence

  def bowler_name
    bowler&.name
  end

  private

  def fielder_present?
    fielder.present?
  end

  def batsman_fielder_team
    return if fielder.team_id != batsman.team_id

    errors.add(:base, "Fielder and batsman can't be of same team")
  end

  def bowler_fielder_team
    return if fielder.team_id == bowler.team_id

    errors.add(:base, 'Fielder and bowler should be of same team')
  end

  def max_wickets
    return unless ball
    return unless ball.match.wickets.where(batsman_id: batsman.team.player_ids).size >= 10

    errors.add(:batsman, 'Max of 10 wickets per team')
  end

  def fielder_presence
    return if fielder_id.blank?
    return if fielder.present?

    errors.add(:fielder, 'is invalid')
  end
end

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
# Indexes
#
#  index_wickets_on_ball_id     (ball_id)
#  index_wickets_on_batsman_id  (batsman_id)
#  index_wickets_on_bowler_id   (bowler_id)
#  index_wickets_on_fielder_id  (fielder_id)
#

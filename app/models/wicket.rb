class Wicket < ApplicationRecord

  belongs_to :batsman, class_name: 'Player', foreign_key: 'batsman_id'
  belongs_to :bowler, class_name: 'Player', foreign_key: 'bowler_id'
  belongs_to :fielder, class_name: 'Player', foreign_key: 'fielder_id'
  belongs_to :ball

  validates :wicket_type, presence: true

  validate :batsman_fielder_team, :bowler_fielder_team, if: :fielder_present?

  def bowler_name
    bowler&.name
  end

  def fielder_present?
    fielder.present?
  end

  def batsman_fielder_team
    return if fielder.team_id != batsman.team_id

    errors.add(:base, "Fielder and batsman can't be of same team")
  end

  def bowler_fielder_team
    return if fielder.team_id == bowler.team_id

    errors.add(:base, "Fielder and bowler can't be of same team")
  end
end

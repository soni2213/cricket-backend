class Player < ApplicationRecord

  belongs_to :team

  validates :name, uniqueness: true, presence: true

  validate :team_size

  private

  def team_size
    return unless team
    return if team.players.count < 11

    errors.add(:base, "Team can't have more than 11 players")
  end
end

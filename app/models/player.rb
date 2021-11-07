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

# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint
#
# Indexes
#
#  index_players_on_name     (name) UNIQUE
#  index_players_on_team_id  (team_id)
#

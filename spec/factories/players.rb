# frozen_string_literal: true

# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint
#
# Indexes
#
#  index_players_on_name     (name) UNIQUE
#  index_players_on_team_id  (team_id)
#
FactoryBot.define do
  factory :player do
    sequence(:name) { |n| "#{team.name}Player#{n}" }
    team { create(:team) }
  end
end

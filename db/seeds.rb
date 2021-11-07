# frozen_string_literal: true

require 'factory_bot_rails'
require 'faker'

team1 = FactoryBot.create(:team, name: 'Bangalore')
team2 = FactoryBot.create(:team, name: 'Lucknow')
# match = FactoryBot.create(:match, toss_winner: team1, status: :in_progress, team1: team1, team2: team2)
team1_players = FactoryBot.create_list(:player, 11, team: team1)
team2_players = FactoryBot.create_list(:player, 11, team: team2)

# team1 batting

# # over 1
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team2_players[-1].id, batsman_id: team1_players[0].id, score: (0..6).to_a.sample)
# # over 2
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team2_players[-2].id, batsman_id: team1_players[1].id, score: (0..6).to_a.sample)
# # over 3
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team2_players[-3].id, batsman_id: team1_players[2].id, score: (0..6).to_a.sample)
# # over 4
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team2_players[-4].id, batsman_id: team1_players[4].id, score: (0..6).to_a.sample)

# # wickets
# (0..5).each do |i|
#   ball = FactoryBot.create(:ball, match: match, bowler_id: team2_players[-4].id, batsman_id: team1_players[4].id, score: (0..6).to_a.sample)
#   FactoryBot.create(:wicket, ball: ball, bowler_id: team2_players[-1].id, batsman_id: team1_players[i].id)
# end
# (6..9).each do |i|
#   ball = FactoryBot.create(:ball, match: match, bowler_id: team2_players[-4].id, batsman_id: team1_players[4].id, score: (0..6).to_a.sample)
#   FactoryBot.create(:wicket, ball: ball, bowler_id: team2_players[-2].id, batsman_id: team1_players[i].id)
# end

# # team2 batting

# # over 1
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team1_players[-1].id, batsman_id: team2_players[0].id, score: (0..6).to_a.sample)
# # over 2
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team1_players[-2].id, batsman_id: team2_players[1].id, score: (0..6).to_a.sample)
# # over 3
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team1_players[-3].id, batsman_id: team2_players[2].id, score: (0..6).to_a.sample)
# # over 4
# FactoryBot.create_list(:ball, 6, match: match, bowler_id: team1_players[-4].id, batsman_id: team2_players[4].id, score: (0..6).to_a.sample)
# # wickets # only 2
# (0..1).each do |i|
#   ball = FactoryBot.create(:ball, match: match, bowler_id: team1_players[-4].id, batsman_id: team2_players[4].id, score: (0..6).to_a.sample)
#   FactoryBot.create(:wicket, ball: ball, bowler_id: team1_players[-1].id, batsman_id: team2_players[i].id)
# end

# match.update(winner_id: team2.id)

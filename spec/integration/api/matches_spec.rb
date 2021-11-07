require 'swagger_helper'

RSpec.describe 'api/matches', type: :request do
  path '/api/matches' do
    let(:user) { FactoryBot.create(:user) }
    let(:team1) { FactoryBot.create(:team) }
    let(:team2) { FactoryBot.create(:team) }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
    let(:Authorization) { auth_headers }

    post('Create a new match!') do
      security [ bearerAuth: [] ]
      tags 'Matches (private)'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :record, in: :body, schema: {
        type: :object,
        properties: {
          team1_id: { type: :integer },
          team2_id: { type: :integer },
          toss_winner_id: { type: :integer }
        },
        required: [ 'toss_winner_id', 'team1_id', 'team2_id' ]
      }

      response(204, 'successful') do
        let(:record) { { toss_winner_id: team1.id, team1_id: team1.id, team2_id: team2.id } }
        run_test!
      end
    end
  end

  path '/api/matches/{id}/record_winner' do
    let(:user) { FactoryBot.create(:user) }
    let(:match) { FactoryBot.create(:match) }
    let(:id) { match.id }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
    let(:Authorization) { auth_headers }

    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('To record winner of match') do
      security [ bearerAuth: [] ]
      tags 'Matches (private)'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :record, in: :body, schema: {
        type: :object,
        properties: {
          winner_id: { type: :integer }
        },
        required: [ 'winner_id' ]
      }

      response(204, 'successful') do
        let(:record) { { winner_id: match.team1.id } }
        run_test!
      end
    end
  end

  path '/api/matches/{id}/update_match_status' do
    let(:user) { FactoryBot.create(:user) }
    let(:match) { FactoryBot.create(:match) }
    let(:id) { match.id }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
    let(:Authorization) { auth_headers }

    parameter name: 'id', in: :path, type: :string, description: 'id'

    put('To update status of match') do
      security [ bearerAuth: [] ]
      tags 'Matches (private)'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :record, in: :body, schema: {
        type: :object,
        properties: {
          status: { type: :string }
        },
        required: [ 'status' ]
      }

      response(204, 'successful') do
        let(:record) { { status: 'completed' } }
        run_test!
      end
    end
  end

  path '/api/matches/{id}/summary' do
    let!(:team1) { FactoryBot.create(:team, name: 'team1') }
    let!(:team2) { FactoryBot.create(:team, name: 'team2') }
    let!(:match) do
      FactoryBot.create(:match, toss_winner_id: team1.id, status: :completed, team1: team1, team2: team2)
    end
    let!(:id) { match.id }

    let!(:team1_players) { FactoryBot.create_list(:player, 11, team: team1) }
    let!(:team2_players) { FactoryBot.create_list(:player, 11, team: team2) }
    let!(:team1_batting) do
      FactoryBot.create_list(:ball, 6, match: match, bowler_id: team2_players[-1].id, batsman_id: team1_players[0].id, score: (0..6).to_a.sample)
    end
    let!(:team2_batting) do
      FactoryBot.create_list(:ball, 6, match: match, bowler_id: team1_players[-1].id, batsman_id: team2_players[0].id, score: (0..6).to_a.sample)
    end

    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('To fetch summary after the game') do
      tags 'Matches (public)'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema type: "object",
          properties: {
            resource: {
              type: "object",
              properties: {
                brief: {
                  type: "object",
                  properties: {
                    team1: { type: "string" },
                    team2: { type: "string" }
                  },
                  required: ['team1', 'team2']
                },
                team1: {
                  type: "object",
                  properties: {
                    team1Player1: {
                      type: "object",
                      properties: {
                        runs: { type: "integer" },
                        balls_played: { type: "integer" },
                        wicket_taker: { type: "string" }
                      },
                      required: [ 'runs', 'balls_played' ]
                    },
                    team1Player2: { type: "object" },
                    team1Player3: { type: "object" },
                    team1Player4: { type: "object" },
                    team1Player5: { type: "object" },
                    team1Player6: { type: "object" },
                    team1Player7: { type: "object" },
                    team1Player8: { type: "object" },
                    team1Player9: { type: "object" },
                    team1Player10: { type: "object" },
                    team1Player11: { type: "object" }
                  },
                  required: [
                    'team1Player1',
                    'team1Player2',
                    'team1Player3',
                    'team1Player4',
                    'team1Player5',
                    'team1Player6',
                    'team1Player7',
                    'team1Player8',
                    'team1Player9',
                    'team1Player10',
                    'team1Player11'
                  ]
                },
                team2: {
                  "type": "object",
                  "properties": {
                    team2Player12: {
                      type: "object",
                      properties: {
                        runs: { type: "integer" },
                        balls_played: { type: "integer" },
                        wicket_taker: { type: "string" }
                      },
                      required: [ 'runs', 'balls_played' ]
                    },
                    team2Player13: { type: "object" },
                    team2Player14: { type: "object" },
                    team2Player15: { type: "object" },
                    team2Player16: { type: "object" },
                    team2Player17: { type: "object" },
                    team2Player18: { type: "object" },
                    team2Player19: { type: "object" },
                    team2Player20: { type: "object" },
                    team2Player21: { type: "object" },
                    team2Player22: { type: "object" }
                  },
                  required: [
                    'team2Player12',
                    'team2Player13',
                    'team2Player14',
                    'team2Player15',
                    'team2Player16',
                    'team2Player17',
                    'team2Player18',
                    'team2Player19',
                    'team2Player20',
                    'team2Player21',
                    'team2Player22'
                  ]
                }
              },
              required: [ 'brief', 'team1', 'team2' ]
            },
            message: { type: "string" }
          },
          required: [ "resource", "message" ]

        run_test!
      end
    end
  end

  path '/api/matches/{id}/record_score' do
    let(:user) { FactoryBot.create(:user) }
    let(:match) { FactoryBot.create(:match) }
    let(:id) { match.id }
    let(:player1) { FactoryBot.create(:player) }
    let(:player2) { FactoryBot.create(:player) }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
    let(:Authorization) { auth_headers }

    parameter name: 'id', in: :path, type: :string, description: 'id'
    post('To record a ball') do
      security [ bearerAuth: [] ]
      tags 'Matches (private)'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :ball, in: :body, schema: {
        type: :object,
        properties: {
          bowler_id: { type: :integer },
          batsman_id: { type: :integer },
          score: { type: :integer },
          wicket_type: { type: :string },
          fielder_id: { type: :integer }
        },
        required: [ 'bowler_id', 'batsman_id', 'score' ]
      }

      response(204, 'successful') do
        let(:ball) { { bowler_id: player1.id, batsman_id: player2.id, score: 2 } }
        run_test!
      end
    end
  end

end

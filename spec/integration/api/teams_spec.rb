require 'swagger_helper'

RSpec.describe 'api/teams', type: :request do
  path '/api/teams/{id}' do
    let(:user) { FactoryBot.create(:user) }
    let(:team) { FactoryBot.create(:team) }
    let(:id) { team.id }
    let(:players) { FactoryBot.create_list(:player, 11, team: team) }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
    let(:Authorization) { auth_headers }

    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show team') do
      security [bearerAuth: []]
      tags 'Teams (private)'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema type: 'object',
               properties: {
                 resource: {
                   type: 'object',
                   properties: {
                     id: { type: 'integer' },
                     name: { type: 'string' },
                     created_at: { type: 'string' },
                     updated_at: { type: 'string' },
                     players: {
                       type: 'array',
                       items: [
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         },
                         {
                           type: 'object',
                           properties: { id: { type: 'integer' }, name: { type: 'string' } },
                           required: %w[id name]
                         }
                       ]
                     }
                   },
                   required: %w[id name created_at updated_at players]
                 },
                 message: { type: 'string' }
               },
               required: %w[resource message]

        run_test!
      end
    end
  end
end

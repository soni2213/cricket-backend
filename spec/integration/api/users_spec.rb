require 'swagger_helper'
require 'devise/jwt/test_helpers'

describe 'Users API' do

  path '/api/signup' do

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'user created' do
        let(:user) { { user: { email: 'foo', password: 'bar' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'foo' } }
        run_test!
      end
    end
  end

  context 'create user' do
    path '/api/users/{id}' do
      let(:user) { User.create!(email: 'foo', password: 'bar') }
      let(:id) { user.id }
      let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }
      let(:Authorization) { auth_headers }

      get 'Retrieves a user' do
        security [ bearerAuth: [] ]
        tags 'Users'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '200', 'user found' do
          schema type: :object,
            properties: {
              resource: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  email: { type: :string }
                },
                required: [ 'id', 'email' ]
              }
            },
            required: [ 'resource' ]

          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end
end
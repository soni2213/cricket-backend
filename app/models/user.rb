# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
end

# frozen_string_literal: true

module Api
  class TeamsController < Api::BaseController
    skip_before_action :authenticate_user!, only: %i[show]

    def show
      team = Team.find(params[:id])
      resource = team.as_json(only: %i[id name created_at updated_at])
                     .merge(players: team.players.as_json(only: %i[id name]))

      render_success(resource: resource)
    end
  end
end

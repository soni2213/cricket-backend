# frozen_string_literal: true

module Api
  class MatchesController < Api::BaseController
    skip_before_action :authenticate_user!, only: %i[summary]
    before_action :set_match

    def record_toss
      @match.update!(toss_params)
    end

    def record_score
      @match.balls.create!(score_params)
    end

    def record_winner
      @match.update!(winner_params)
    end

    def summary
      render_success(resource: Match::Summary.new(@match).print)
    end

    private

    def set_match
      @match = Match.find(params[:id])
    end

    def score_params
      params.permit(:bowler_id,
                    :batsman_id,
                    :wicket_type,
                    :fielder_id,
                    :score,
                    :extra)
    end

    def toss_params
      params.permit(:toss_winner_id)
            .merge(status: 'toss')
    end

    def winner_params
      params.permit(:winner_id)
            .merge(status: 'completed')
    end
  end
end
